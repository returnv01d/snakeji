require 'ruby2d'
require 'ruby2d/dsl'
require_relative 'menu/panel'
require_relative 'menu/bounding_box'
require_relative 'models/game_model'
require_relative 'menu/button'
require_relative 'utility/point'
require_relative 'menu/key_panel'
class Menu
  def initialize
    @width = GameModel.instance.get(:WINDOW_WIDTH)
    @height = GameModel.instance.get(:WINDOW_HEIGHT)
    @bg_color = GameModel.instance.get(:MENU_BG_COLOR)
    Application.set(height: @height, width: @width, background: @bg_color)
    @width_padding = @width * (1.0 / 32)
    @height_padding = @height * (1.0 / 24)
    create_view
  end

  def create_view

    create_button_panel
    create_main_panel

    Application.show
  end

  def create_main_panel
    point = Point.new(0, @height_padding)
    bounding_box = BoundingBox.new(point, @width, @height * (5.0 / 6) - 2 * @height_padding)
    @main_panel = MainPanel.new(bounding_box, @bg_color)
  end

  def create_button_panel
    button_panel_color = GameModel.instance.get(:MENU_BUTTON_PANEL_COLOR)
    point = Point.new(0, @height * (5.0 / 6) - @height_padding)
    puts @height
    bounding_box = BoundingBox.new(point, @width, @height - @height * (5.0 / 6) + @height_padding)
    @button_panel = ButtonPanel.new(bounding_box, button_panel_color)
  end
end

class MainPanel < Panel
  def initialize(bounding_box, color)
    super(bounding_box, color)
    @width_padding = 1.0 / 16 * @bounding_box.width
    @height_padding = 1.0 / 18 * @bounding_box.height
    @player_panel_color = GameModel.instance.get(:MENU_PLAYER_PANEL_COLOR)
    create_panels
  end

  def create_panels
    2.times do |height_step|
      2.times do |width_step|
        panel_point = Point.new(@bounding_box.top_left.x + width_step * (@bounding_box.width / 2.0) + @width_padding,
                                @bounding_box.top_left.y + height_step * (@bounding_box.height / 2.0 + @height_padding))
        create_panel(panel_point, true)
      end
    end
  end

  def create_panel(offset_point, active)
    bounding_box = BoundingBox.new(offset_point,
                                   @bounding_box.width / 2.0 - 2 * @width_padding,
                                   @bounding_box.height / 2.0 - @height_padding)
    panel = KeyPanel.new(
      bounding_box,
      active: active,
      active_color: @player_panel_color
    )
    panel.on_click

  end
end

class ButtonPanel
  def initialize(bounding_box, color)
    @bounding_box = bounding_box
    @color = color
    @button_width = @bounding_box.width / 8
    @button_height = @bounding_box.height / 4
    create_panel
    create_button

  end

  def create_panel
    panel = Panel.new(@bounding_box, @color)
  end
  def create_button
    top_left_point = Point.new((@bounding_box.top_left.x + @bounding_box.width / 2.0) - @button_width / 2.0,
        (@bounding_box.top_left.y + @bounding_box.height / 2.0) - @button_height / 2.0)
    button_bounding_box = BoundingBox.new(top_left_point,
                                   @button_width,
                                   @button_height)
    @button = BorderedButton.new('Go!',
                                 bounding_box: button_bounding_box,
                                 border_width: 2,
                                 border_color: '#000000', button_color: '#777777')

  end
end

Menu.new
