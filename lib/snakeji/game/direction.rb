class Direction

  def self.random
    possible_directions = [-1, 0, 1]
    x_velocity = possible_directions.sample
    y_velocity =  x_velocity.zero? ? (possible_directions - [0]).sample : 0
    [x_velocity, y_velocity]
  end

  def self.up
    [0, -1]
  end

  def self.down
    [0, 1]
  end

  def self.is_opposite?(dir1, dir2)
    ((dir1[0] * -1) == dir2[0]) && ((dir1[1] * -1) == dir2[1])
  end

  def self.right
    [1, 0]
  end

  def self.left
    [-1, 0]
  end
end