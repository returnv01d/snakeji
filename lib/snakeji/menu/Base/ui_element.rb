#require_relative '../../menu.rb'
class UIElement

  attr_accessor :width, :height, :bg_color, :width_padding, :height_padding
  attr_reader :x, :y, :parent, :active
  def initialize(width, height, opts = {})
    @height = height
    @width = width
    @width_padding = opts[:width_padding] || 0
    @height_padding = opts[:height_padding] || 0
    @bg_color = opts[:bg_color] || 'white'
    @parent = opts[:parent]
    @opacity = opts[:opacity] || 1
    @active = opts[:active].nil? ? true : opts[:active]
    @z = opts[:z] || 0
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
                          color: @bg_color,
                          z: @z)
    @rect.opacity = @opacity
    @rect.add
  end

  def contains?(point_x, point_y)
    x = @x

    y = @y
    (x..(x + @width)).cover?(point_x) && (y..(y + @height)).cover?(point_y)
  end

end

