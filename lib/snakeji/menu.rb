require 'ruby2d'
require_relative 'models/game_model'

class Menu
  def initialize
    @width = GameModel.instance.get(:WINDOW_WIDTH)
    @height = GameModel.instance.get(:WINDOW_HEIGHT)
    @window = Window.new(height: @height, width: @width)
    @window.set(background: '#1f1f21')
    @width_padding = @width * (1.0 / 16)
    @height_padding = @height * (1.0 / 24)
    create_view
  end

  def create_view
    @main_panel = MainPanel.new(0, 0 + @height_padding,
                                @width,
                                @height * (5.0 / 6) - @height_padding)

    @window.add(@main_panel.rects)
    @window.show
  end
end

class MainPanel
  attr_accessor :rects, :panel_1
  def initialize(top_left_x, top_left_y, width, height)
    @top_left_x = top_left_x
    @top_left_y = top_left_y
    @width = width
    @height = height
    @width_padding = 1.0 / 14 * @width
    @height_padding = 1.0 / 18 * @height
    @rects = []
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
    panel = PlayerPanel.new(x_offset,
                            y_offset,
                            @width / 2.0 - 2 * @width_padding,
                            @height / 2.0 - @height_padding)
    @rects << panel.rect
  end
end

class PlayerPanel
  attr_accessor :rect
  def initialize(top_left_x, top_left_y, width, height)
    @rect = Rectangle.new(x: top_left_x, y: top_left_y,
                          width: width,
                          height: height,
                          color: '#5e5e66')
  end
end

Menu.new
