require 'ruby2d'
require 'json'

require 'snakeji/game/snake'
require 'snakeji/game/player'
require 'snakeji/models/game_model'
require 'snakeji/utility/point'



class Game
  def initialize(window_width, window_height, number_of_players, players_keys, players_emojiis)
    @window_width = GameModel.model['GAME']['WINDOW_WIDTH'] = window_width
    @window_height = GameModel.model['GAME']['WINDOW_HEIGHT'] = window_height
    @players = create_players(number_of_players, players_keys, players_emojiis)
    draw_snakes
    @paused = false
    @game_time = 0
    @debug_speed = 1
    create_view(window_width, window_height)
  end

  def update
    Application.update do
      if (@game_time % @debug_speed).zero?
        unless @paused
          @players.each do |player|
            player.update
            if player.snake.out_of_window? || player.snake.contains_self?
              #puts "Removing player #{player.__id__}"
              player.remove
            end
          end
        end

      end
      @game_time += 1
    end

  end

  def create_players(number_of_players, players_keys, players_emojiis)
    players = []
    number_of_players.times do |i|
      player = Player.new(i, players_keys[i], players_emojiis[i])
      players << player
    end
    players
  end

  def draw_snakes
    @players.each do |player|
      collides_with_other_snake = false
      other_players = @players - [player]
      other_players_snakes = other_players.collect(&:snake)
      loop do
        spawn_snake(player.snake)

        other_players_snakes.each do |other_snake|
          collides_with_other_snake = player.snake.contains_snake?(other_snake)
          break if collides_with_other_snake
        end

        break unless player.snake.out_of_window? || collides_with_other_snake
      end
    end
  end

  def spawn_snake (snake)
    snake_x = Point.valid_coordinate(snake, snake.direction[0], @window_width)
    snake_y = Point.valid_coordinate(snake, snake.direction[1], @window_height)
    snake.draw(snake_x.to_i, snake_y.to_i)
  end

  def create_view(window_width, window_height)
    Application.set(title: 'Snakejii', height: window_height.to_i, width: window_width.to_i)
    Application.set(resizable: true, background: '#123456')
  end

  def show!
    on_keys
    update
    Application.show
  end

  def on_keys
    Application.on :key_down do |e|
      case e.key
        when 'b'
          @paused = !@paused
        when 'n'
          @debug_speed = 10
      end
    end
  end
end

