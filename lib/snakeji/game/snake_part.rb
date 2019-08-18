require 'ruby2d'
require '../utility/utility'
class SnakePart
  attr_accessor :current_vector, :width, :part

  include Comparable
  def initialize(path, direction, parent)
    @width = (GameModel.model['GAME']['WINDOW_WIDTH'] * 1.0 / 32.0).to_i

    @part = Image.new( "#{$LOAD_PATH[0]}/../assets/emojis/#{path}.png",
                      width: @width, height: @width, z: 1)
    @current_vector = direction
    @parent = parent
  end

  def draw(x, y)
    @part.x = x
    @part.y = y
  end

  def height
    @width
  end

  def x
    @part.x
  end

  def y
    @part.y
  end

  def <=>(another_part)
    if self.object_id > another_part.object_id
      -1
    elsif self.object_id < another_part.object_id
      1
    else
      0
    end
  end

  def update
    snake_speed = @parent.player.stats[:snake_speed]

    @part.x += snake_speed * @current_vector[0]
    @part.y += snake_speed * @current_vector[1]
  end

  def add
    Window.add(@part)
  end

  def delete
    Window.remove(@part)
    @part = nil
  end

  def out_of_window?
    @part.x < 0 || @part.x + @width > GameModel.model['GAME']['WINDOW_WIDTH'] ||
      @part.y < 0 || @part.y + @width > GameModel.model['GAME']['WINDOW_HEIGHT']
  end

  def contains?(other)
    in_range?(other.x, other.width, @part.x, @part.width) &&
        in_range?(other.y, other.height, @part.y, @part.height)
  end

  def in_range?(other_coordinate, other_len, coordinate, len)
    (other_coordinate..other_coordinate + other_len).cover?(coordinate) ||
        (other_coordinate..other_coordinate + other_len).cover?(coordinate + len)
  end

  def intersects?(other)
    radius = @width / 2
    middle_x = x + radius
    middle_y = y + radius

    other_radius = other.width / 2
    other_middle_x = other.x + other_radius
    other_middle_y = other.y + other_radius

    Utility.distance_between_two_points(middle_x, middle_y,
                                        other_middle_x, other_middle_y) < radius + other_radius

  end
end