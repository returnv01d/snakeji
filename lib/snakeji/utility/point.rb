class Point
  EXTRA_DISTANCE = 20

  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def self.valid_coordinate(obj, direction, bound)
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
end