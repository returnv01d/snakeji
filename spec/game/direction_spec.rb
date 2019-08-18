require 'rspec'
require 'snakeji/game/direction'

RSpec.describe Direction.random do

  it 'should produce valid directions' do
    valid_directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
    expect(valid_directions).to include(Direction.random)
  end
end