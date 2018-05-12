class BoundingBox
  attr_accessor :top_left, :width, :height
  def initialize(top_left_point, width, height)
    @top_left = top_left_point
    @width = width
    @height = height
  end

  def contains?(point)
    x = @top_left.x
    y = @top_left.y
    (x..(x + @width)).cover?(point.x) && (y..(y + @height)).cover?(point.y)
  end
end