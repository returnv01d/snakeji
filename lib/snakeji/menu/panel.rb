require_relative '../../../lib/snakeji/utility/point'
class Panel
  attr_accessor :rect, :bounding_box
  def initialize(bounding_box, color)
    @bounding_box = bounding_box
    @color = color
    @rect = Rectangle.new(x: @bounding_box.top_left.x,
                          y: @bounding_box.top_left.y,
                          width: @bounding_box.width,
                          height: @bounding_box.height,
                          color: @color)
    Application.add(@rect)
  end


end
