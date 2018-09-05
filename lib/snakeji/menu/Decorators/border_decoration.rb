require_relative 'ui_element_decoration'
require_relative '../Base/ui_element'

module BorderDecoration
  attr_accessor :rect
  def set_props (opts = {})
    @border_color = opts[:border_color] || [0, 0, 0, 1]
    @border_size = opts[:border_size] || 5
  end

  def create_rect
    create_border
    @rect = Rectangle.new(x: @x + @border_size,
                          y: @y + @border_size,
                          height: @height - 2 * @border_size,
                          width: @width - 2 * @border_size,
                          color: @bg_color,
                          z: 0)
    @rect.add
    super()
  end

  def create_border
    @border = Rectangle.new(x: @x,
                            y: @y,
                            height: @height,
                            width: @width,
                            color: @border_color,
                            z: 0)
    @border.add
  end
end