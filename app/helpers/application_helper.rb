module ApplicationHelper
  # vvvvvv parkerhill standard  vvvvvv

  def config(setting)
    Rails.application.config.send setting
  end

  def title(page_title, show: true)
    @show_title = show
    content_for :title do
      page_title
    end
    content_tag :h1, page_title if show
  end

  def flash_class_for(level)
    'alert alert-dismissable ' +
      case level
      when 'success' then 'alert-success' # green
      when 'notice'  then 'alert-info'    # blue
      when 'alert'   then 'alert-warning' # yellow
      when 'error'   then 'alert-warning' # yellow ('alert-danger' - red)
      else                'alert-info'    # blue
      end
  end

  # vvvvvv app specific vvvvvv

  def mountain_ribbon(mtn)
    "#{mtn.name} (#{number_with_delimiter mtn.elevation}')"
  end

  def hiker_chip(hiker)
    html = if hiker.profile_chip_url
      "<img class='chip' src='#{hiker.profile_chip_url}' title='#{hiker.name}'/>"
    else
      "<span class='chip glyphicon glyphicon-user' title='#{hiker.name}'></span>"
    end.html_safe
    link_to html, hiker
  end

  def hiker_ribbon(hiker)
    if hiker.profile_chip_url
       "<div class='selection_item'><img class='chip', src='#{hiker.profile_chip_url}'/>#{hiker.name}</div>"
     else
       "<div class='selection_item'><span class='chip glyphicon glyphicon-user'></span>#{hiker.name}</div>"
     end.html_safe
   end

end
