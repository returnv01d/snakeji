require_relative '../../../lib/snakeji/utility/point'
require_relative 'panel'
require_relative 'key_label'
require_relative 'bounding_box'
class KeyPanel < UIElement

  ACTIVE_COLOR = [1, 0, 0, 1]
  INACTIVE_COLOR = [0, 0, 1, 1]
  attr_accessor :bounding_box, :active, :key_labels
  def initialize(opts = {})
    @parent = opts[:parent]
    @width = GameModel.model['WINDOW_WIDTH'] / 2.0 - (2 * @parent.width_padding)
    @height = GameModel.model['WINDOW_HEIGHT'] / 2.0 - @parent.height_padding
    @bg_color = GameModel.model['MENU']['PLAYER_PANEL_COLOR']
    super(@width, @height, bg_color: @bg_color)
    @key_labels = []
  end

  def create_labels
    4.times do |step|
      @key_labels << create_label(create_point(step),
                                  GameModel.model['MENU']['KEY_LABELS'][step])
    end
  end

  def create_point(step)
    key_label_width_padding = @bounding_box.width * GameModel.get_ratio('KEY_PANEL_LABEL_WIDTH_PADDING')
    key_label_height_padding = @bounding_box.height * GameModel.get_ratio('KEY_PANEL_LABEL_HEIGHT_PADDING')
    key_label_x = @bounding_box.top_left.x + key_label_width_padding
    key_label_y = @bounding_box.top_left.y + key_label_height_padding
    Point.new(key_label_x,
                      key_label_y + @bounding_box.height * ((2 * step) / 8.0))
  end

  def create_label(offset_point, label_content)
    key_label_width = @bounding_box.width * GameModel.get_ratio('KEY_PANEL_LABEL_WIDTH')
    key_label_height = @bounding_box.height * GameModel.get_ratio('KEY_PANEL_LABEL_HEIGHT')
    bounding_box = BoundingBox.new(offset_point,
                                   key_label_width,
                                   key_label_height
                                   )
    key_label = KeyLabel.new(bounding_box, label_content, "S", '#454455')
    key_label
  end

  def create_close_button
    button_width = @width * 1.0 / 12.0
    button_height = @width * 1.0 / 12.0
    @close_button = Image.new(
      x: @x + @width - button_width,
      y: @y,
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
        @key_labels.each { |label| label.unselect; label.active }
      end
    end
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)
    create_close_button
  end
  def color
    if @active
      @active_color
    else
      @inactive_color
    end
  end
end