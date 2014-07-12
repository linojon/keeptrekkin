module ApplicationHelper
  # vvvvvv parkerhill standard  vvvvvv

  def config(setting)
    Rails.application.config.send setting
  end

  def title(page_title, show: true)
    @show_title = show
    content_tag :h1, page_title
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

end
