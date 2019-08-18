require 'snakeji/models/game_model'

class TurnPoint
  attr_reader :turn_direction
  attr_accessor :affected_parts
  def initialize(turn_direction)
    @turn_direction = turn_direction
    @width = (GameModel.model['GAME']['WINDOW_WIDTH'] * 1.0 / 32.0)
    @turn_point = Image.new("#{$LOAD_PATH[0]}/../assets/emojis/poop.png",
                            width: @width, height: @width, z: 1)
    @affected_parts = []
  end

  def add_affected_part (part)
    @affected_parts << part
  end

  def affected? (part)
    @affected_parts.include?(part)
  end

  def draw(x, y)
    @turn_point.x = x
    @turn_point.y = y
    add
  end

  def x
    @turn_point.x
  end

  def width
    @width
  end

  def height
    @width
  end

  def y
    @turn_point.y
  end

  def add
    Window.add(@turn_point)
  end

  def delete
    Window.remove(@turn_point)
    @turn_point = nil
    @affected_parts.clear
  end

end