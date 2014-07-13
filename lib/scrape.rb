# require 'nokogiri'
# require 'open_uri'

class Scrape
  class << self

    # ref nokogiri for jquery users https://github.com/sparklemotion/nokogiri/wiki/From-jQuery

    def fourkfooters(url)
      # eg url: 'http://4000footers.com/adams.shtml'
      # scraping: 
      agent = Mechanize.new
      page = agent.get url
      #                                                  td     tr     td's                 
      nodes = page.at("td strong:contains('Elevation')").parent.parent.children.children # go from header to content
      info = {}
      nodes.each_with_index do |node, i| 
        case node.text.strip.split(' ').first

        when 'Elevation'
          #  ": 804 feet (245 meters)"
          conv = nodes[i+1].text.match(/\: (\d,\d+)/)

          info[:elevation]        = conv[1].gsub(',','').to_i

        # when 'Prominence'

        when 'Location:'
          info[:location] = nodes[i+1].text.strip

        when 'Coordinates:'
          # http://stackoverflow.com/questions/1317178/parsing-latitude-and-longitude-with-ruby
          # node.text == %Q{Coordinates: 44°19'14" North     71°17'29" W﻿est}
          conv = node.text.gsub(/(\d+)°(\d+)'(\d+)"/) do
            $1.to_f + $2.to_f/60 + $3.to_f/3600
          end
          # conv == "Coordinates: 44.32055555555556 North     71.29138888888889 W﻿est"
          # https://www.ruby-forum.com/topic/4408724
          info[:lat], info[:lng] = conv.match(/(\d+\.\d+)/).to_a.map(&:to_f)

        when 'Rating'
          info[:rating] = nodes[i+3].text.strip #?

        when 'Features:'
          # ?

        when 'Distance of highlighted hike below:'
          info[:hikes] = nodes[(i+1)..-1].join(' ') # take the rest of them ?
        end
      end

      td = page.at("td[width='381'] strong:contains('Elevation')").parent
      tr = td.parent
      table = tr.parent
      # up to 3 paragraphs
      ele = table
      content = 1.upto(3).map do
        ele = ele.next_element
        ele.to_s if ele && ele.name == 'p'
      end.join('')
      content = ActionController::Base.helpers.strip_links content
      content += "<p class='small align_right'>- description courtesy of <a href='#{url}'>4000footers.com</a></p>"
      info[:description] = content
      info
    end

    def amc_index
      agent = Mechanize.new
      page  = agent.get "http://www.outdoors.org/recreation/tripplanner/plan/4kfooter-guide.cfm"
      i = Rails.env.production? ? 0 : 1 # dont know hy localhost offset is 1, heroku 0
      rows  = page.search("#standardTable tr")
      mountains = rows.inject({}) do |h, row|
        if row[:id] =~ /rowColor/
          cells       = row.children
          mountain    = cells[i].text.split('.')[1].strip # "1. Washington\n"
          mountain = 'Wildcat, D Peak' if mountain == 'Wildcat D'
          mountain = "Owl's Head" if mountain == "Owl’s Head" # different apostrophe
          path        = cells[i].at('a')[:href]
          elevation   = cells[i+2].text
          rating      = cells[i+4].text.strip
          h[mountain] = {url: 'http://www.outdoors.org'+path, rating: rating}
        end
        h
      end
    end

    def wikipedia_index
      agent = Mechanize.new
      page  = agent.get "http://en.wikipedia.org/wiki/Four-thousand_footers"
      # byebug
      mountains = Mountain.all.inject({}) do |h, mountain|
        name = mountain.name
        name = 'Wildcat D' if name == 'Wildcat, D Peak'
        # pp name
        atag = page.at "a:contains(\"#{name}\")"
        path = atag[:href]
        h[mountain.name] = { url: 'http://en.wikipedia.org'+path }
        h
      end
    end

    def trailsnh_index
      agent = Mechanize.new
      page  = agent.get "http://trailsnh.com/lists/New-Hampshire-4000-Footers.php"
      menu  = page.at("#peakmenu span:contains('NH: 4000')").next.next
      # expect menu[:class] == 'peaks'
      mountains = Mountain.all.inject({}) do |h, mountain|
        name = mountain.name
        name = 'Owls Head' if name == "Owl's Head"
        name = 'Wildcat D' if name == 'Wildcat, D Peak'
        atag = menu.at "a:contains('#{name}')"
        path = atag[:href]
        h[mountain.name] = { url: "http://trailsnh.com"+path }
        h
      end
    end

    def summitpost_index
      agent = Mechanize.new
      page  = agent.get "http://www.summitpost.org/object_list.php?object_type=1&state_province_1=New+Hampshire&sort_select_1=elevation"
      results1 = page.at('#results')
      page2 = agent.get "http://www.summitpost.org/object_list.php?state_province_1=New+Hampshire&object_type=1&orderby=elevation&page=2"
      results2 = page2.at('#results')
      mountains = Mountain.all.inject({}) do |h, mountain|
        name = mountain.name
        name = 'Carter Mountain, Middle and South' if name =~ /Carter/
        name = 'Kinsman Mountain, North and South' if name =~ /Kinsman/
        name = 'Hancock, North Peak and South Peak' if name =~ /Hancock/
        name = 'Mount Tripyramid' if name =~ /Tripyramid/
        name = 'Mount Moriah (NH)' if name == 'Moriah'

        if name != 'Wildcat, D Peak'
          atag = results1.at "a:contains(\"#{name}\")"
          atag ||= results2.at "a:contains(\"#{name}\")"
          path = atag[:href]
          h[mountain.name] = { url: "http://www.summitpost.org"+path }
        end
        h
      end
    end

  end
end