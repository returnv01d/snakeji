require_relative 'alignment'

class HorizontalAlignment < Alignment
  def initialize(elements, element_spacing)
    super(elements, element_spacing)
  end

  def update_last_x (element)
    @last_x += element.width + @element_spacing
  end

end