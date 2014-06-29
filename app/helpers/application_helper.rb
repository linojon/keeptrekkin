module ApplicationHelper
  # vvvvvv parkerhill standard  vvvvvv

  def config(setting)
    Rails.application.config.send setting
  end

  def title(page_title, show: true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show
  end

  def show_title?
    @show_title
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
