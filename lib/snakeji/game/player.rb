require_relative 'player_statistics'

class Player
  attr_reader :snake
  def initialize(id, keys, emojii)
    @id = id
    @keys = keys
    @snake = Snake.new(emojii)
    @stats = PlayerStatistics.default
    @power_ups = []
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
          puts 'up'
        when @keys['DOWN']
          puts 'dwon'
        when @keys['LEFT']
          puts 'left'
        when @keys['RIGHT']
          puts 'right'
      end
    end
  end
end