class UIElement
  attr_accessor :x, :y, :width, :height, :bg_color, :width_padding, :height_padding, :parent
  def initialize(width, height, opts = {})
    @height = height
    @width = width
    puts opts
    @bg_color = opts[:bg_color] || [1, 1, 1, 1]
    @width_padding = opts[:width_padding] || 0
    @width_padding = opts[:height_padding] || 0
    @parent = opts[:parent]
  end

  def draw(top_left_x, top_left_y)
    @x = top_left_x
    @y = top_left_y
    create_rect
  end

  def create_rect
    @rect = Rectangle.new(x: @x,
                          y: @y,
                          height: @height,
                          width: @width,
                          color: @bg_color)
    @rect.add
  end

  def contains?(point)
    x = @x
    y = @y
    (x..(x + @width)).cover?(point.x) && (y..(y + @height)).cover?(point.y)
  end

end

