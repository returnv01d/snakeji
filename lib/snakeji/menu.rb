require 'ruby2d'
require_relative 'models/game_model'

class Menu
  def initialize
    @width = GameModel.instance.get(:WINDOW_WIDTH)
    @height = GameModel.instance.get(:WINDOW_HEIGHT)
    @window = Window.new(height: @height, width: @width)
    @window.set(background: '#1f1f21')
    @width_padding = @width * (1.0 / 16)
    @height_padding = @height * (1.0 / 12)
    create_view
  end

  def create_view
    @main_panel = MainPanel.new(0 + @width_padding, 0 + @height_padding,
                                @width - @width_padding,
                                @height * (5 / 6) - @height_padding)
    @window.add(@main_panel.rects)
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
    @width_padding = 1.0 / 14 * @width
    @height_padding = 1.0 / 12 * @height
    @panels = []
    @rects = []
    create_panels
  end

  def create_panels
    panel_1 = PlayerPanel.new(@x,  @y, @width/2.0 - @width_padding, @height/2.0 - @height_padding )
    @panels << panel_1
    @rects << panel_1.rect
  end
end
class PlayerPanel
  attr_accessor :rect
  def initialize(x, y, width, height)
    @rect = Rectangle.new(x: x, y: y, width: width, height: height,  color:'#5e5e66')
  end
end

Menu.new
