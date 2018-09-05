require 'ruby2d'
require_relative 'models/game_model'
require_relative 'menu/button_panel'
require_relative 'menu/main_panel'
require_relative 'menu/bottom_button'

class Menu

  attr_accessor :height_padding
  def initialize
    @width = GameModel.model['WINDOW_WIDTH']
    @height = GameModel.model['WINDOW_HEIGHT']
    @bg_color = GameModel.model['MENU']['BG_COLOR']
    Application.set(height: @height, width: @width, background: @bg_color)
    @width_padding = @width * 1.0 / 32.0
    @height_padding = @height * 1.0 / 24.0
    create_view

  end

  def create_view
    #create_button_panel
    create_main_panel
    draw(0, 0)
    Application.show
  end

  def create_main_panel
    @main_panel = MainPanel.new(parent: self)
  end

  def create_button_panel
    bounding_box = BoundingBox.new(point, @width, @height - @main_panel_height + @height_padding)
    @button_panel = ButtonPanel.new(bounding_box, button_panel_color)
  end

  def draw(top_left_x, top_left_y)
    @main_panel.draw(0, @height_padding)
    #@button_panel.draw(0, @main_panel.height - @height_padding)
  end
end


Menu.new
