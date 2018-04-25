require_relative 'basic_control'

class Panel < BasicControl
  attr_accessor :rects, :rect
  def initialize(top_left_x, top_left_y, width, height, color)
    super(top_left_x, top_left_y, width, height)
    @color = color
    @rects = []
    @rect = Rectangle.new(x: @top_left_x, y: @top_left_y,
                          width: @width,
                          height: @height,
                          color: @color)
    @rects << rect
  end
end
