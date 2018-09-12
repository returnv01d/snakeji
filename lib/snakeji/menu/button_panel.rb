require_relative '../menu/Base/composite_ui_element'
require_relative 'resolution_selector_button'
class ButtonPanel < CompositeUIElement
  BG_COLOR = GameModel.model['MENU']['BUTTON_PANEL_COLOR']

  def initialize(opts = {})
    parent = opts[:parent]
    width = GameModel.model['WINDOW_WIDTH']
    height = GameModel.model['WINDOW_HEIGHT'] * 1.0 / 6.0 + 2 * parent.height_padding
    super(width, height, bg_color: BG_COLOR, parent: parent)
  end

  def create_button
    @button = Button.new(create_button_bounding_box,
                                 text: 'Go!',
                                 border_width: 2,
                                 border_color: '#000000',
                                 button_color: '#777777',
                                 text_size: 20)
  end

  def create_button_bounding_box
    button_bounding_box = BoundingBox.new(create_button_top_left_point,
                                          @button_width,
                                          @button_height)
    button_bounding_box
  end

  def create_button_top_left_point
    top_left_point = Point.new(
        (@bounding_box.top_left.x + @bounding_box.width / 2.0) - @button_width / 2.0,
        (@bounding_box.top_left.y + @bounding_box.height / 2.0) - @button_height / 2.0)
    top_left_point
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)
    @start_button = BottomButton.new
    button_x = (top_left_x + @width / 2.0) - @start_button.width / 2.0
    @start_button.draw(button_x, top_left_y)
    @selector_button = ResolutionSelectorButton.new
    button_y = @start_button.y + @start_button.height + 15
    button_x = (top_left_x + @width / 2.0) - @selector_button.width / 2.0
    @selector_button.draw(button_x, button_y)


  end

end