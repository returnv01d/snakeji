require 'rspec'
require 'snakeji/models/game_model'
require 'snakeji/game/game'
require 'snakeji/game/snake'

RSpec.describe 'Snake generating' do
  game = Game.new(800, 600, 2,['s', 's'],['poop', 'poop'])

  it 'should check for snake collsion' do
    snake1 = Snake.new('poop', 8)
    snake1.direction = [1, 0]
    snake2 = Snake.new('poop', 1)
    snake2.direction = [1, 0]

    snake1.draw(500, 3)
    snake2.draw(500, 3)

    expect(snake1.contains_snake?(snake2)).to eql(true)

  end
end