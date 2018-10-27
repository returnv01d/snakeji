require 'snakeji/game/snake_part'
require 'snakeji/models/game_model'
require 'snakeji/game/direction'

class Snake
  NUMBER_OF_PARTS = 4
  DEFAULT_PART_PATH = GameModel.model['GAME']['REGULAR_EMOJII_PATH']

  attr_reader :direction
  def initialize path
    @direction = Direction.random
    @parts = create_parts path
  end

  def create_parts path
    parts = []
    parts << SnakePart.new(path, @direction)
    NUMBER_OF_PARTS.times do
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

end