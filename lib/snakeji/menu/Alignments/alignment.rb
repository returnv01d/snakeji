class Alignment
  def initialize(elements, element_spacing)
    @elements = elements
    @element_spacing = element_spacing
  end

  def draw(top_left_x, top_left_y)
    @last_x = top_left_x
    @last_y = top_left_y
    @elements.each_with_index do |element, index|
      element.draw(calculate_element_x(element, index),
                   calculate_element_y(element, index))
    end
  end

  def calculate_element_x(element, index)
    @last_x
  end

  def calculate_element_y(element, index)
    @last_y
  end

  def height
    @elements[0].height
  end
end