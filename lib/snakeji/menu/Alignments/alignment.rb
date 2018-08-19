class Alignment
  def initialize(elements, element_spacing)
    @elements = elements
    @element_spacing = element_spacing
  end

  def draw(top_left_x, top_left_y)
    @elements.each_with_index do |element, index|
      element.draw(calculate_element_x(top_left_x, index),
                   calculate_element_y(top_left_y, index))
    end
  end

  def calculate_element_x(top_left_x, index)
    top_left_x
  end

  def calculate_element_y(top_left_y, index)
    top_left_y
  end
end