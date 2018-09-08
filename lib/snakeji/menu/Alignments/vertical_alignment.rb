require_relative 'alignment'

class VerticalAlignment < Alignment
  def initialize(elements, element_spacing)
    super(elements, element_spacing)
  end

  def calculate_element_y(element, index)
    index.zero? ? @last_y : @last_y += element.height + @element_spacing
  end
end