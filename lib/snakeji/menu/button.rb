require 'ruby2d'
require 'observer'
class BorderedButton
  attr_accessor :selected, :border, :text, :bounding_box, :on_click
  def initialize(bounding_box, opts = {})
    @bounding_box = bounding_box
    @border_width = opts[:border_width] || 5
    @border_color = opts[:border_color] || 'black'
    @button_color = opts[:button_color] || 'white'
    @selected_border_color = opts[:selected_border_color]
    @button_text = opts[:text] || ''
    @text_size = opts[:text_size] || 15
    @selected = false
    create_button
    create_text
    on_click
  end

  def create_button
    create_border
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
                     size: @text_size)
    center_text
    @text.add
  end

  def center_text
    @text.x -= @text.width / 2.0
    @text.y -= @text.height / 2.0
  end

  def change_border
    @selected = !@selected
    @border.color = active_color
  end

  def active_color
    if @selected
      @selected_border_color
    else
      @border_color
    end
  end

  def on_click=(on_click)
    @on_click = on_click

    Application.on :mouse_up do |e|
      if @bounding_box.contains?(Point.new(e.x, e.y))
        @on_click.call
      end
    end
  end

end