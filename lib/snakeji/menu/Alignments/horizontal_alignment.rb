require_relative 'alignment'

class HorizontalAlignment < Alignment
  def initialize(elements, element_spacing)
    super(elements, element_spacing)
  end

  def calculate_element_x(element, index)
    index.zero? ? @last_x : @last_x += element.width + @element_spacing
  end

end