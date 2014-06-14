module ApplicationHelper

  def flash_class_for(level)
    'alert alert-dismissable' +
      case level
      when 'success' then 'alert-success' # green
      when 'notice'  then 'alert-info'    # blue
      when 'alert'   then 'alert-warning' # yellow
      when 'error'   then 'alert-warning' # yellow ('alert-danger' - red)
      else                'alert-info'    # blue
      end
  end

end
