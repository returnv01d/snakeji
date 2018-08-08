require 'ruby2d'
require 'ruby2d/dsl'
require_relative 'menu/bounding_box'
require_relative 'models/game_model'
require_relative 'utility/point'
require_relative 'menu/button_panel'
require_relative 'menu/main_panel'
require_relative 'menu/Base/ui_element'
require_relative 'menu/Decorators/border_decoration'
require_relative 'menu/bottom_button'
class Menu
  def initialize
    @width = GameModel.model['WINDOW_WIDTH']
    @height = GameModel.model['WINDOW_HEIGHT']
    @bg_color = GameModel.model['MENU']['BG_COLOR']
    Application.set(height: @height, width: @width, background: @bg_color)
    initialize_properties
    create_view
  end

  def initialize_properties
    @width_padding = @width * 1.0 / 32.0
    @height_padding = @height * 1.0 / 24.0
    @main_panel_height = @height * GameModel.get_ratio('MAIN_PANEL_HEIGHT')
  end

  def create_view
   # create_button_panel
    create_main_panel
    thiss = BottomButton.new()
    thiss.draw(100, 100)
    puts thiss.class
    Application.show
  end

  def create_main_panel
    point = Point.new(0, @height_padding)
    bounding_box = BoundingBox.new(point, @width, @main_panel_height - 2 * @height_padding)
    @main_panel = MainPanel.new()
    @main_panel.draw(0, @height_padding)
  end

  def create_button_panel
    button_panel_color = GameModel.model['MENU']['BUTTON_PANEL_COLOR']
    point = Point.new(0, @main_panel_height - @height_padding)
    bounding_box = BoundingBox.new(point, @width, @height - @main_panel_height + @height_padding)
    @button_panel = ButtonPanel.new(bounding_box, button_panel_color)
  end
end


Menu.new
