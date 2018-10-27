require_relative 'key_label'
require_relative 'emojii_panel'
require_relative 'Controllers/key_labels_controller'
require_relative 'Base/composite_ui_element'

class KeyPanel < CompositeUIElement
  include Observable


  BG_COLOR = GameModel.model['MENU']['KEY_PANEL_BG_COLOR'].freeze

  attr_accessor :key_labels, :emojii_panel
  def initialize(key_contents, opts = {})
    parent = opts[:parent]
    width = GameModel.model['MENU']['WINDOW_WIDTH'] / 2.0 - (2 * parent.width_padding)
    height = parent.height / 2.0 - parent.height_padding
    super(width, height, bg_color: BG_COLOR, parent: parent, active: opts[:active])
    @key_contents = key_contents
    on_click
    create_sub_elements
  end

  def create_close_button
    button_width = @width * 1.0 / 14.0
    button_height = @width * 1.0 / 14.0

    @close_button = Image.new(
      x: @x + @width - button_width,
      y: @y,
      width: button_width,
      height: button_height,
      path: '../../assets/menu_close.png'
    )

    @close_button.add
  end

  def on_click
    Application.on :mouse_up do |e|
      if @close_button.contains?(e.x, e.y)
        @active = !@active
        @sub_elements.each(&:hide)
        change_color
      end
    end
  end

  def change_color
    @rect.color = @active ? BG_COLOR : @parent.bg_color
  end

  def create_key_labels
    key_labels_controller = KeyLabelsController.new
    @key_labels = []

    4.times do |step|
      key_label = KeyLabel.new(GameModel.model['MENU']['KEY_LABELS'][step],
                               @key_contents[step],
                               parent: self)
      key_labels_controller << key_label
      @key_labels << key_label
    end

    @key_labels
  end

  def create_sub_elements
    @emojii_panel = EmojiiPanel.new(parent: self)
    @sub_elements += create_key_labels
    @sub_elements << @emojii_panel
  end

  def activate_first_free_emojii
    @emojii_panel.activate_first_free_emojii
  end

  def player_keys
    player_keys = {}

    @key_labels.each{|label|
      key_label = label.key_label
      key_value = label.current_key
      player_keys[key_label.intern] = key_value # intern converts string to symbol
    }
    player_keys
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)
    change_color
    create_close_button
    @width_padding = @width * 1.0 / 16.0
    @height_padding = @height * 1.0 / 20.0

    alignment = VerticalAlignment.new(@sub_elements, @height_padding)
    alignment.draw(top_left_x + @width_padding, top_left_y + @height_padding)
  end

end