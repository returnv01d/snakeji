require_relative 'alignment'

class VerticalAlignment < Alignment
  def initialize(elements, element_spacing)
    super(elements, element_spacing)
  end

  def calculate_element_y(top_left_y, index)
    top_left_y + index * @element_spacing
  end
end