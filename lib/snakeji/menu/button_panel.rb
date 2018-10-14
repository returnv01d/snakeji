require_relative '../menu/Base/composite_ui_element'
require_relative 'resolution_selector_button'
class ButtonPanel < CompositeUIElement
  BG_COLOR = GameModel.model['MENU']['BUTTON_PANEL_COLOR']
  attr_reader :start_button
  def initialize(opts = {})
    parent = opts[:parent]
    width = GameModel.model['MENU']['WINDOW_WIDTH']
    height = GameModel.model['MENU']['WINDOW_HEIGHT'] * 1.0 / 6.0 + 2 * parent.height_padding
    super(width, height, bg_color: BG_COLOR, parent: parent)
    create_sub_elements

  end

  def create_sub_elements
    @start_button = BottomButton.new
    @selector_button = ResolutionSelectorButton.new
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)

    button_x = (top_left_x + @width / 2.0) - @start_button.width / 2.0
    @start_button.draw(button_x, top_left_y)

    button_y = @start_button.y + @start_button.height
    button_x = (top_left_x + @width / 2.0) - @selector_button.width / 2.0
    @selector_button.draw(button_x, button_y)
  end

  def current_resolution_width
    @selector_button.current_option[0]
  end

  def current_resolution_height
    @selector_button.current_option[1]
  end

end