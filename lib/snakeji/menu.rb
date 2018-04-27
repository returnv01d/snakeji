require 'ruby2d'
require 'ruby2d/dsl'
require_relative 'menu/panel'
require_relative 'models/game_model'
require_relative 'menu/button'

class Menu

  def initialize
    @width = GameModel.instance.get(:WINDOW_WIDTH)
    @height = GameModel.instance.get(:WINDOW_HEIGHT)
    @bg_color = GameModel.instance.get(:MENU_BG_COLOR)
    Application.set(height: @height, width: @width, background: @bg_color)
    @width_padding = @width * (1.0 / 16)
    @height_padding = @height * (1.0 / 24)
    create_view
  end

  def create_view
    create_main_panel
    create_button_panel
    Application.show
  end

  def create_main_panel
    @main_panel = MainPanel.new(0, 0 + @height_padding,
                                @width, @height * (5.0 / 6) - @height_padding,
                                @bg_color)
    Application.add(@main_panel.rects)
  end

  def create_button_panel
    button_panel_color = GameModel.instance.get(:MENU_BUTTON_PANEL_COLOR)
    @button_panel = ButtonPanel.new(0, @height * (5.0 / 6),
                                    @width, @height - @height * (5.0 / 6),
                                    button_panel_color)
    Application.add(@button_panel.rects)
  end
end

class MainPanel < Panel
  def initialize(top_left_x, top_left_y, width, height, color)
    super(top_left_x, top_left_y, width, height, color)
    @width_padding = 1.0 / 14 * @width
    @height_padding = 1.0 / 18 * @height
    @player_panel_color = GameModel.instance.get(:MENU_PLAYER_PANEL_COLOR)
    create_panels
  end

  def create_panels
    2.times do |height_step|
      2.times do |width_step|
        create_panel(@top_left_x + width_step * (@width / 2.0) + @width_padding,
                     @top_left_y + height_step * (@height / 2.0 + @height_padding))
      end
    end
  end

  def create_panel(x_offset, y_offset)

    panel = Panel.new(x_offset,
                      y_offset,
                      @width / 2.0 - 2 * @width_padding,
                      @height / 2.0 - @height_padding, @player_panel_color)

  end
end

class ButtonPanel < Panel
  def initialize(top_left_x, top_left_y, width, height, color)
    super(top_left_x, top_left_y, width, height, color)

    panel = Panel.new(top_left_x, top_left_y, width, height, color)
    button_width = @width / 8
    button_height = @height / 4
    button = BorderedButton.new('Go!',
                                top_left_x: (top_left_x + width / 2.0) - button_width / 2.0,
                                top_left_y: (top_left_y + height / 2.0) - button_height / 2.0,
                                width: button_width, height: button_height,
                                border_width: 2,
                                border_color: '#000000', button_color: '#777777')

  end
end

Menu.new
