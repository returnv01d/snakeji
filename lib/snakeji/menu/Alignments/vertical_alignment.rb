require_relative 'alignment'

class VerticalAlignment < Alignment
  def initialize(elements, element_spacing)
    super(elements, element_spacing)
  end

  def update_last_y (element)
    @last_y += element.height + @element_spacing
  end
end