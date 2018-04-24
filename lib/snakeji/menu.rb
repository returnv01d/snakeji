require 'ruby2d'
require_relative 'models/game_model'

class Menu
  def initialize
    @window = Window.new(height:GameModel.instance.get(:WINDOW_HEIGHT), width:GameModel.instance.get(:WINDOW_WIDTH) )
    dark_grey = Color.new("#8B7D6B")
    puts Color::is_hex?("#8B7D6B")
    @window.set(background: "#1f1f21")
    @width_padding = GameModel.instance.get(:WINDOW_WIDTH) * (1.0/12)
    @height_padding = GameModel.instance.get(:WINDOW_HEIGHT)* (1.0/16)
    @mainpanel = MainPanel.new(0 + @width_padding, 0 + @height_padding,
                               GameModel.instance.get(:WINDOW_WIDTH) -  @width_padding, GameModel.instance.get(:WINDOW_HEIGHT) * (13.0/16) - @height_padding)
    @window.add(@mainpanel.rects)
    @window.show
  end
end
class MainPanel
  attr_accessor :rects, :panel_1
  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
    @width_padding =  1.0/10 * @width
    @height_padding =  1.0/12 * @height
    @panels = Array.new
    @rects = Array.new
    panel_1 = PlayerPanel.new(@x,  @y, @width/2.0 - @width_padding, @height/2.0 - @height_padding )
    panel_2 = PlayerPanel.new(@width/2.0 + @width_padding,  @y, @width/2.0 - @width_padding, @height/2.0 - @height_padding )
    panel_3 = PlayerPanel.new(@x,  @y + @height/2 + @height_padding, @width/2.0 - @width_padding, @height/2.0 - @height_padding )
    panel_4 = PlayerPanel.new(@width/2.0 + @width_padding,  @y + @height/2 + @height_padding, @width/2.0 - @width_padding, @height/2.0 - @height_padding )
    @panels << panel_1 << panel_2
    @rects << panel_1.rect << panel_2.rect << panel_3.rect << panel_4.rect


  end
end
class PlayerPanel
  attr_accessor :rect
  def initialize(x, y, width, height)
    @rect = Rectangle.new(x: x, y: y, width: width, height: height,  color:'#5e5e66')
  end
end

Menu.new
