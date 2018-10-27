require 'ruby2d'
require 'json'

require 'snakeji/game/snake'
require 'snakeji/game/player'
require 'snakeji/models/game_model'



class Game
  EXTRA_DISTANCE = 20
  def initialize(window_width, window_height, number_of_players, players_keys, players_emojiis)
    @window_width = GameModel.model['GAME']['WINDOW_WIDTH'] = window_width
    @window_height = GameModel.model['GAME']['WINDOW_HEIGHT'] = window_height
    @players = create_players(number_of_players, players_keys, players_emojiis)
    draw_snakes
    update
    create_view(window_width, window_height)
  end

  def update
    Application.update do
      puts 'update game'
      @players.each(&:update)
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
        spawn_snake(player)

        other_players_snakes.each do |other_snake|
          collides_with_other_snake = player.snake.contains_snake?(other_snake)
          break if collides_with_other_snake
        end

        break unless player.snake.out_of_window? || collides_with_other_snake
      end
    end
  end

  def spawn_snake (player)
    snake = player.snake
    snake_x = valid_coordinate(snake, snake.direction[0], @window_width)
    snake_y = valid_coordinate(snake, snake.direction[1], @window_height)
    player.draw_snake(snake_x.to_i, snake_y.to_i)
  end

  def valid_coordinate(obj, direction, bound)
    random = Random.new

    obj_length = obj.respond_to?(:length) ? obj.length : obj.size
    obj_direction = direction || 0

    case obj_direction
      when -1
        random.rand(0 + EXTRA_DISTANCE..bound - obj_length - EXTRA_DISTANCE)
      when 0
        random.rand(0 + obj.size + EXTRA_DISTANCE..bound - obj.size - EXTRA_DISTANCE)
      when 1
        random.rand(0 + obj_length..bound - EXTRA_DISTANCE)
    end
  end

  def create_view(window_width, window_height)
    Application.set(title: 'Snakejii', height: window_height.to_i, width: window_width.to_i)
    Application.set(resizable: true, background: '#123456')
    Application.show
  end


end

window_width = 800
window_height = 640
player_keys_string = '[{"UP":"w","DOWN":"s","LEFT":"a","RIGHT":"d"},{"UP":"up","DOWN":"down","LEFT":"left","RIGHT":"right"}]'
player_keys = JSON.parse(player_keys_string)
player_emojiis = JSON.parse('["smile", "sunglasses"]')
Game.new(window_width, window_height,   2, player_keys, player_emojiis)
#Game.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3], ARGV[4])