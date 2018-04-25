class Panel
  attr_accessor :rects, :rect
  def initialize(top_left_x, top_left_y, width, height, color)
    @top_left_x = top_left_x
    @top_left_y = top_left_y
    @width = width
    @height = height
    @color = color
    @rects = []
    @rect = Rectangle.new(x: @top_left_x, y: @top_left_y,
                         width: @width,
                         height: @height,
                         color: @color)
    @rects << rect
  end
end
