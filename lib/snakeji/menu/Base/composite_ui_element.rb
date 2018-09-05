require_relative 'ui_element'

class CompositeUIElement < UIElement
  attr_accessor :sub_elements
  def initialize(width, height, opts = {})
    super(width, height, opts)
    @sub_elements = []
  end

  def add_sub_element(sub_element)
    @sub_elements << sub_element
  end

  def delete_sub_element(sub_element)
    @sub_elements.delete(sub_element)
  end

  def render

  end

end