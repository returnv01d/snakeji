require 'ruby2d'
require_relative 'basic_control'
class BorderedButton < BasicControl
  attr_accessor :border, :button, :text
  def initialize(text, opts = {})
    super(opts[:top_left_x], opts[:top_left_y], opts[:width], opts[:height])
    @border_width = opts[:border_width] || 5
    @border_color = opts[:border_color] || 'black'
    @button_color = opts[:button_color] || 'white'
    @button_text = text
    create_button
    create_text
  end

  def create_button
    @border = Rectangle.new(x: @top_left_x, y: @top_left_y, height: @height,
                            width: @width, color: @border_color)
    @button = Rectangle.new(x: @top_left_x + @border_width,
                            y: @top_left_y + @border_width,
                            height: @height - 2 * @border_width,
                            width: @width - 2 * @border_width,
                            color: @button_color)
    @button.add
    @border.add
  end

  def create_text
    size = 20
    @text = Text.new(x: (@top_left_x + (@width / 2)),
                     y: (@top_left_y + (@height / 2)),
                     text: @button_text,
                     font: '../../fonts/Vera.ttf',
                     size: size)

    @text.x -= @text.width / 2.0
    @text.y -= @text.height / 2.0
  end
end