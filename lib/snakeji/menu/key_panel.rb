require_relative '../../../lib/snakeji/utility/point'
require_relative 'panel'
class KeyPanel
  attr_accessor :bounding_box, :active
  def initialize(bounding_box, opts = {})
    @bounding_box = bounding_box
    @active = opts[:active] || true
    @active_color = opts[:active_color] || [1, 0, 0, 1]
    @inactive_color = opts[:inactive_color] || [0, 0, 1, 1]
    @panel = Panel.new(@bounding_box, color)
    create_close_button
  end

  def create_close_button
    button_width = @bounding_box.width * 1.0 / 8.0
    button_height = @bounding_box.width * 1.0 / 8.0
    @close_button =Image.new(
      x: @bounding_box.top_left.x + @bounding_box.width - button_width,
      y: @bounding_box.top_left.y,
      width: button_width,
      height: button_height,
      path: '../../assets/menu_close.png'
    )
    Application.add(@close_button)
  end

  def on_click
    Application.on :mouse_up do |e|
      if @close_button.contains?(e.x, e.y)
        @active = !@active
        @panel.rect.color = color
      end
    end
  end

  def color
    if @active
      @active_color
    else
      @inactive_color
    end
  end
end