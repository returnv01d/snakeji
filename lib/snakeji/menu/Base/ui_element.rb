class UIElement
  attr_accessor :width, :height, :bg_color, :width_padding, :height_padding
  attr_reader :x, :y, :parent, :active
  def initialize(width, height, opts = {})
    @height = height
    @width = width
    @bg_color = opts[:bg_color] || [1, 1, 1, 1]
    @width_padding = opts[:width_padding] || 0
    @width_padding = opts[:height_padding] || 0
    @parent = opts[:parent]
    @opacity = opts[:opacity] || 1
    @active = opts[:active].nil? ? true : opts[:active]
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
    @rect.opacity = @opacity
    @rect.add
  end

  def contains?(point_x, point_y)
    x = @x

    y = @y
    (x..(x + @width)).cover?(point_x) && (y..(y + @height)).cover?(point_y)
  end

end

