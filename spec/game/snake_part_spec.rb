require 'rspec'
require 'snakeji/game/snake_part'
require 'snakeji/models/game_model'

RSpec.describe SnakePart do

  it 'should check if it is in window ' do
    GameModel.model['GAME']['WINDOW_WIDTH'] = 800
    GameModel.model['GAME']['WINDOW_HEIGHT'] = 600

    valid = SnakePart.new('poop.png', [0, 0])
    valid.draw(rand(800), rand(600))
    invalid = SnakePart.new('poop.png', [0, 0])
    invalid.draw(rand(800) * [-1, 1].sample, rand(600) * [-1, 1].sample)

    puts "WIDTH: #{GameModel.model['GAME']['WINDOW_WIDTH']}, HEIGHT: #{GameModel.model['GAME']['WINDOW_HEIGHT']}"
    puts "Valid.x: #{valid.x}, Valid.y: #{valid.y}"
    puts "Invalid.x: #{invalid.x}, Invalid.y: #{invalid.y}"
    expect(valid.out_of_window?).to eql(false)
    expect(invalid.out_of_window?).to eql(true)
  end
end