class Direction

  def self.random
    possible_directions = [-1, 0, 1]
    x_velocity = possible_directions.sample
    y_velocity =  x_velocity.zero? ? (possible_directions - [0]).sample : 0
    [x_velocity, y_velocity]
  end
end