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
      nodes = page.at("td[width='381'] strong:contains('Elevation')").parent.children
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
      page = agent.get "http://www.outdoors.org/recreation/tripplanner/plan/4kfooter-guide.cfm"
      rows = page.search("#standardTable tr")
      mountains = rows.inject({}) do |h, row|
        if row[:id] =~ /rowColor/
          cells       = row.children
          mountain    = cells[1].text.split('.')[1].strip # "1. Washington\n"
          mountain = 'Wildcat, D Peak' if mountain == 'Wildcat D'
          mountain = "Owl's Head" if mountain == "Owl’s Head" # different apostrophe
          url         = cells[1].at('a')[:href]
          elevation   = cells[3].text
          rating      = cells[5].text.strip
          h[mountain] = {url: 'http://www.outdoors.org'+url, rating: rating}
        end
        h
      end


    end

  end
end