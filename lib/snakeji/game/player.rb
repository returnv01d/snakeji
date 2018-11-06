require 'snakeji/game/player_statistics'
require 'snakeji/game/turn_point'
require 'snakeji/game/direction'

class Player
  STARTING_SNAKE_LENGTH = 4

  attr_reader :snake
  def initialize(id, keys, emojii)
    @id = id
    @keys = keys
    @snake = Snake.new(emojii, STARTING_SNAKE_LENGTH, Direction.random)
    @stats = PlayerStatistics.default
    @power_ups = []
    @turn_points = []
    on_keys
  end

  def draw_snake(x, y)
    @snake.draw(x, y)
  end

  def update
    puts 'update player'
  end

  def on_keys
    Application.on :key_down do |e|
      case e.key
        when @keys['UP']
          make_turn_point(Direction.up)
        when @keys['DOWN']
          make_turn_point(Direction.down)
        when @keys['LEFT']
          make_turn_point(Direction.left)
        when @keys['RIGHT']
          make_turn_point(Direction.right)
      end
    end
  end

  def make_turn_point(new_direction)
    current_snake_direction = @snake.head_vec
    return if Direction.is_opposite?(current_snake_direction, new_direction) ||
        current_snake_direction == new_direction

    turn_point_x = @snake.head_x - (current_snake_direction[0] == -1 ? @snake.size : 0)
    turn_point_y = @snake.head_y - (current_snake_direction[1] == -1 ? @snake.size : 0)

    @turn_points << TurnPoint.new(new_direction)
                             .draw(turn_point_x, turn_point_y)
  end
end