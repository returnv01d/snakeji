require_relative 'key_label'
require_relative 'emojii_panel'
require_relative 'Controllers/key_labels_controller'

class KeyPanel < CompositeUIElement
  include Observable

  INACTIVE_BG_COLOR = GameModel.model['MENU']['KEY_PANEL_INACTIVE_BG_COLOR'].freeze
  BG_COLOR = GameModel.model['MENU']['KEY_PANEL_BG_COLOR'].freeze

  attr_accessor :key_labels, :emojii_panel, :INACTIVE_BG_COLOR
  def initialize(key_contents, opts = {})
    parent = opts[:parent]
    width = GameModel.model['WINDOW_WIDTH'] / 2.0 - (2 * parent.width_padding)
    height = parent.height / 2.0 - parent.height_padding
    super(width, height, parent: parent, active: opts[:active])
    @key_contents = key_contents
    @bg_color = color
    on_click
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
        changed(true)
        notify_observers(@active, @emojii_panel)
        @sub_elements.each(&:hide)
      end
    end
  end

  def create_key_labels
    key_labels_controller = KeyLabelsController.new
    key_labels = []

    4.times do |step|
      key_label = KeyLabel.new(GameModel.model['MENU']['KEY_LABELS'][step],
                               @key_contents[step],
                               parent: self)
      key_labels_controller << key_label
      key_labels << key_label
    end

    key_labels
  end

  def create_sub_elements
    @emojii_panel = EmojiiPanel.new(parent: self)
    @sub_elements += create_key_labels
    @sub_elements << @emojii_panel
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)
    create_close_button
    @width_padding = @width * 1.0 / 12.0
    @height_padding = @height * 1.0 / 12.0
    alignment = VerticalAlignment.new(@sub_elements, @height_padding * 2)
    alignment.draw(top_left_x + @width_padding, top_left_y + @height_padding)

  end

  def color
    if @active
      BG_COLOR
    else
      INACTIVE_BG_COLOR
    end
  end

end