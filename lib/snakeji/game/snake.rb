require 'snakeji/game/snake_part'
require 'snakeji/models/game_model'
require 'snakeji/game/direction'

class Snake
  DEFAULT_PART_PATH = GameModel.model['GAME']['REGULAR_EMOJII_PATH']

  attr_reader :direction, :player
  attr_accessor :turn_points

  def initialize (path, starting_length, starting_direction, player)
    @player = player
    @direction = starting_direction
    @parts = create_parts(path, starting_length)
    @turn_points = []
  end

  def update
    @parts.each_with_index do |part, i|
      @turn_points.each do |point|
        # if(i == 0)
        #   puts "part x: #{part.x} part y: #{part.y} part width: #{part.width} part height: #{part.height}"
        #   puts "other x: #{point.x} other y: #{point.y} other width: #{point.width} part height: #{point.height}"
        # end

        if part.contains?(point) && !point.affected?(part)
          point.add_affected_part(part)
          part.current_vector = point.turn_direction

          if @parts.sort! == point.affected_parts.sort!
            @turn_points.delete(point)
            point.delete
          end
        end
      end

      part.update
    end

  end

  def stop
    @parts.each do |part|
      part.current_vector = [0, 0]
    end

  end

  def create_parts(path, starting_length)
    parts = []
    parts << SnakePart.new(path, @direction, self)

    starting_length.times do
      parts << SnakePart.new(DEFAULT_PART_PATH, @direction, self)
    end

    parts
  end

  def size
    @parts[0].width
  end

  def add
    @parts.each(&:add)
  end

  def head_vec
    @parts[0].current_vector
  end

  def head_x
    @parts[0].x + (head_vec[0] == 1 ? size : 0)
  end

  def head_y
    @parts[0].y + (head_vec[1] == 1 ? size : 0)
  end

  def hide
    @parts.each(&:hide)
  end

  def draw(x, y)
    @parts.each_index do |i|
      @parts[i].draw(x - i * @parts[i].width * @direction[0],
                     y - i * @parts[i].width * @direction[1])
    end

    add
  end

  def out_of_window?
    @parts.each do |part|
      return true if part.out_of_window?
    end

    false
  end

  def contains_self?
    head = @parts[0]
    snake_parts_without_two_first_parts = @parts.drop(2)
    snake_parts_without_two_first_parts.each do |part|
      if head.intersects?(part) && !Direction.is_opposite?(head.current_vector, part.current_vector)
        part.part.width += 5
        puts part
        return true
      end
    end

    false
  end

  def length
    @parts.count * @parts[0].width
  end

  def contains_snake?(other)
    @parts.each do |part|
      return true if other.contains?(part)
    end

    false
  end

  def contains?(other)
    @parts.each do |part|
      return true if part.contains?(other)
    end
    false
  end

end