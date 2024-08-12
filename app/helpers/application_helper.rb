module ApplicationHelper
  ##
  # The function `bootstrap_class_for_flash` returns the corresponding Bootstrap alert class based on
  # the input flash type.
  #
  # Args:
  #   flash_type: The `flash_type` parameter is a string that represents the type of flash message,
  # such as 'success', 'error', 'alert', or 'notice'. The method `bootstrap_class_for_flash` takes
  # this `flash_type` as input and returns the corresponding Bootstrap alert class that should be used
  # to
  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-primary'
    else
      flash_type.to_s
    end
  end
end
