require 'snakeji/game/player_statistics'
require 'snakeji/game/turn_point'
require 'snakeji/game/direction'

class Player
  STARTING_SNAKE_LENGTH = 4
  TURN_COOLDOWN = 20
  attr_reader :snake, :stats
  def initialize(id, keys, emojii)
    @id = id
    @keys = keys
    @stats = PlayerStatistics.default
    @snake = Snake.new(emojii, STARTING_SNAKE_LENGTH, Direction.random, self)
    @power_ups = []
    on_keys
    @turn_cooldown = 0
  end

  def draw_snake(x, y)
    @snake.draw(x, y)
  end

  def update
    @snake.update
    @turn_cooldown -= 1
  end

  def remove
    @snake.stop
  end

  def on_keys
    Window.on :key_down do |e|
      case e.key
        when @keys['UP']
          change_snake_direction(Direction.up)
        when @keys['DOWN']
          change_snake_direction(Direction.down)
        when @keys['LEFT']
          change_snake_direction(Direction.left)
        when @keys['RIGHT']
          change_snake_direction(Direction.right)
      end
    end
  end

  def change_snake_direction(new_direction)
    return unless @turn_cooldown < 0

    if !Direction.is_opposite?(@snake.head_vec, new_direction) || @snake.head_vec == new_direction
      make_turn_point(new_direction)
      @turn_cooldown = TURN_COOLDOWN
    end
  end

  def make_turn_point(new_direction)
    snake = @snake
    current_snake_direction = snake.head_vec

    turn_point_x = snake.head_x - (current_snake_direction[0] == -1 ? snake.size : 0)
    turn_point_y = snake.head_y - (current_snake_direction[1] == -1 ? snake.size : 0)

    turn_point = TurnPoint.new(new_direction)
    turn_point.draw(turn_point_x, turn_point_y)
    snake.turn_points << turn_point
  end
end