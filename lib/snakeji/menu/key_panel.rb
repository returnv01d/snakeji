require_relative '../../../lib/snakeji/utility/point'
require_relative 'panel'
require_relative 'key_label'
class KeyPanel
  attr_accessor :bounding_box, :active
  def initialize(bounding_box, opts = {})
    @bounding_box = bounding_box
    @active = opts[:active] || true
    @active_color = opts[:active_color] || [1, 0, 0, 1]
    @inactive_color = opts[:inactive_color] || [0, 0, 1, 1]
    @panel = Panel.new(@bounding_box, color)
    @key_labels = []
    create_close_button
    create_labels
  end

  def create_labels
    4.times do | step |
      @key_labels << create_label(create_point(step))
    end
  end

  def create_point(step)
    Point.new(@bounding_box.top_left.x + @bounding_box.width * 1.0 / 12.0,
                      @bounding_box.top_left.y + @bounding_box.height * 1.0 / 9.0 + @bounding_box.height * ((2 * step) / 8.0))
  end

  def create_label(offset_point)
    bounding_box = BoundingBox.new(offset_point,
                                   @bounding_box.width * 10.0 / 12.0,
                                   @bounding_box.height * 1.0 / 8.0)
    key_label = KeyLabel.new(bounding_box, "Down", "S", '#454455')
    key_label
  end

  def create_close_button
    button_width = @bounding_box.width * 1.0 / 8.0
    button_height = @bounding_box.width * 1.0 / 8.0
    @close_button = Image.new(
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