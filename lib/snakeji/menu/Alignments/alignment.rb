class Alignment
  def initialize(elements, element_spacing)
    @elements = elements
    @element_spacing = element_spacing
  end

  def draw(top_left_x, top_left_y)
    @last_x = top_left_x
    @last_y = top_left_y
    @elements.each do |element|
      element.draw(@last_x, @last_y)
      update_last_x element
      update_last_y element
    end
  end

  def update_last_x (element)
    @last_x
  end

  def update_last_y (element)
    @last_y
  end

  def height
    @elements[0].height
  end
end