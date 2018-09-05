require_relative 'alignment'

class HorizontalAlignment < Alignment
  def initialize(elements, element_spacing)
    super(elements, element_spacing)
  end

  def calculate_element_x(top_left_x, index)
    top_left_x + index * @element_spacing
  end
end