require 'ruby2d'

class BorderedButton
  attr_accessor :border, :button, :text, :bounding_box
  def initialize(text, opts = {})
    @bounding_box = opts[:bounding_box]
    @border_width = opts[:border_width] || 5
    @border_color = opts[:border_color] || 'black'
    @button_color = opts[:button_color] || 'white'
    @button_text = text
    create_border
    create_button
    create_text
  end

  def create_button
    @button = Rectangle.new(x: @bounding_box.top_left.x + @border_width,
                            y: @bounding_box.top_left.y + @border_width,
                            height: @bounding_box.height - 2 * @border_width,
                            width: @bounding_box.width - 2 * @border_width,
                            color: @button_color)
    @button.add
  end

  def create_border
    @border = Rectangle.new(x: @bounding_box.top_left.x,
                            y: @bounding_box.top_left.y,
                            height: @bounding_box.height,
                            width: @bounding_box.width,
                            color: @border_color)
    @border.add
  end

  def create_text
    @text = Text.new(x: (@bounding_box.top_left.x + (@bounding_box.width / 2)),
                     y: (@bounding_box.top_left.y + (@bounding_box.height / 2)),
                     text: @button_text,
                     font: '../../fonts/Vera.ttf',
                     size: 20)
    center_text
    @text.add
  end

  def center_text
    @text.x -= @text.width / 2.0
    @text.y -= @text.height / 2.0
  end
end