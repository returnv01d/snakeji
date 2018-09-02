require_relative '../../../lib/snakeji/utility/point'
require_relative 'panel'
require_relative 'key_label'
require_relative 'bounding_box'
class KeyPanel < CompositeUIElement

  INACTIVE_COLOR = [0, 0, 1, 1].freeze
  BG_COLOR = GameModel.model['MENU']['PLAYER_PANEL_COLOR']

  attr_accessor :bounding_box, :active, :key_labels
  def initialize(id, opts = {})
    @parent = opts[:parent]
    @active = opts[:active]
    @id = id
    @width = GameModel.model['WINDOW_WIDTH'] / 2.0 - (2 * @parent.width_padding)
    @height = @parent.height / 2.0 - @parent.height_padding
    @bg_color = color
    super(@width, @height, bg_color: @bg_color, parent: @parent)
    create_sub_elements
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
        @rect.color = color
        @sub_elements.each { |label| label.unselect; label.active }
      end
    end
  end

  def create_sub_elements
    4.times do |step|
      @sub_elements << KeyLabel.new(GameModel.model['MENU']['KEY_LABELS'][step],
                                    GameModel.model['MENU']['KEYS'][@id][step],
                                    parent: self)
    end

  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)
    create_close_button
    @width_padding = @width * 1.0 / 12.0
    @height_padding = @height * 1.0 / 12.0
    alignment = VerticalAlignment.new(@sub_elements, @height * 2.0 / 12.0)
    alignment.draw(top_left_x + @width_padding, top_left_y + @height_padding)
  end

  def color
    if @active
      BG_COLOR
    else
      INACTIVE_COLOR
    end
  end
end