require_relative '../menu/Alignments/table_alignment'
require_relative '../menu/Controllers/emojii_panels_controller'
require_relative 'key_panel'

class MainPanel < CompositeUIElement

  BG_COLOR = GameModel.model['MENU']['BG_COLOR']

  attr_accessor :emojii_controller
  def initialize(opts = {})
    parent = opts[:parent]
    width = GameModel.model['WINDOW_WIDTH']
    height = GameModel.model['WINDOW_HEIGHT'] * 5.0 / 6.0 - 2 * parent.height_padding
    width_padding = 1.0 / 16.0 * width
    height_padding = 1.0 / 18.0 * height
    super(width, height,
          width_padding: width_padding, height_padding: height_padding,
          bg_color: BG_COLOR, parent: parent)
  end

  def create_panel(id, active)
    key_contents = GameModel.model['MENU']['KEYS'][id-1]
    panel = KeyPanel.new(key_contents, parent: self, active: active)
    @emojii_controller << panel.emojii_panel
    add_sub_element(panel)
  end

  def active_panels_count
    @sub_elements.select(&:active).count
  end

  def players_keys
    keys = []
    active_panels = @sub_elements.select(&:active)
    active_panels.each { |panel| keys << panel.player_keys }
    keys
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)

    create_panels

    horizontal_spacing = (@width / 12.0)
    vertical_spacing = @height_padding

    panels_alignment = TableAlignment.new(@sub_elements, 2,
                                          horizontal_spacing, vertical_spacing)
    panels_alignment.draw(top_left_x + @width_padding, top_left_y)

    @sub_elements.each(&:activate_first_free_emojii)
  end

  def create_panels
    @emojii_controller = EmojiiPanelsController.new
    create_panel(1, true); create_panel(2, true)
    create_panel(3, false); create_panel(4, false)

  end
end
