require 'snakeji/game/snake_part'
require 'snakeji/models/game_model'
require 'snakeji/game/direction'

class Snake
  DEFAULT_PART_PATH = GameModel.model['GAME']['REGULAR_EMOJII_PATH']

  attr_reader :direction
  def initialize (path, starting_length, starting_direction)
    @direction = starting_direction
    @parts = create_parts path, starting_length
  end

  def create_parts (path, starting_length)
    parts = []
    parts << SnakePart.new(path, @direction)
    starting_length.times do
      parts << SnakePart.new(DEFAULT_PART_PATH, @direction)
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