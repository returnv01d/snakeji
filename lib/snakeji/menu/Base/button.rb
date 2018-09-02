require 'ruby2d'
require 'observer'
require_relative '../Decorators/border_decoration'
require_relative 'ui_element'

class Button < UIElement
  attr_accessor :selected, :border, :text, :on_click
  def initialize(width, height, text = '', opts = {})
    super(width, height, opts)

    extend(BorderDecoration)
    set_props(opts)
    @selected_border_color = opts[:selected_border_color]
    @button_text = text
    @text_size = opts[:text_size] || 15
    @selected = false

  end

  def create_rect
    create_text
  end

  def create_text
    @text = Text.new(x: (@x + (@width / 2)),
                     y: (@y + (@height / 2)),
                     text: @button_text,
                     font: '../../fonts/Vera.ttf',
                     size: @text_size)
    center_text
    @text.add
  end

  def center_text
    @text.x = @x + (@width / 2.0) - (@text.width / 2.0)
    @text.y = @y + (@height / 2.0) - (@text.height / 2.0)
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


end