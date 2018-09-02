require_relative '../menu/Alignments/horizontal_alignment'
require_relative '../menu/Alignments/vertical_alignment'
require_relative '../menu/Alignments/table_alignment'
require_relative 'key_panel'

class MainPanel < CompositeUIElement
  BG_COLOR = GameModel.model['MENU']['BG_COLOR']

  def initialize(opts = {})
    @parent = opts[:parent]
    @width = GameModel.model['WINDOW_WIDTH']
    @height = GameModel.model['WINDOW_HEIGHT'] * 5.0 / 6.0 - 2 * @parent.height_padding
    super(@width, @height, bg_color: BG_COLOR, parent: @parent)
    @width_padding = 1.0 / 16.0 * @width
    @height_padding = 1.0 / 18.0 * @height
    @key_labels = []
  end

  def create_panel(id, active)
    panel = KeyPanel.new(id, parent: self, active: active)
    panel.on_click
    @key_labels += panel.sub_elements
    add_sub_element(panel)
  end

  def observe
    @key_labels.each { |label| label.add_observer(self) }
  end

  def update(key_label)
    @key_labels -= [key_label]
    @key_labels.each(&:unselect)
    @key_labels << key_label
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)

    create_panels

    horizontal_spacing = (@width / 2.0)
    vertical_spacing = @height / 2.0 + @height_padding

    panels_alignment = TableAlignment.new(@sub_elements, 2,
                                          horizontal_spacing, vertical_spacing)
    panels_alignment.draw(top_left_x + @width_padding, top_left_y)
  end

  def create_panels
    create_panel(1, true); create_panel(2, true)
    create_panel(3, false); create_panel(4, false)
    observe
  end
end
