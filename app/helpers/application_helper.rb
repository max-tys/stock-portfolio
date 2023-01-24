# Formats numbers - two decimal places and a thousands separator.
module ApplicationHelper
  def number_format(number)
    number_with_precision(number, precision: 2, delimiter: ',')
  end
end
