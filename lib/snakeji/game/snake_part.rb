require 'ruby2d'
class SnakePart
  attr_accessor :current_vector, :width
  def initialize (path, direction)
    @width = (GameModel.model['GAME']['WINDOW_WIDTH'] * 1.0 / 32.0).to_i

    @part = Image.new(path: "#{$LOAD_PATH[0]}/../assets/emojis/#{path}.png",
                      width: @width, height: @width, z: 1)
    @current_vector = direction
  end

  def draw(x, y)
    @part.x = x
    @part.y = y
  end

  def height
    @width
  end

  def x
    @part.x
  end

  def y
    @part.y
  end

  def add
    Application.add(@part)
  end

  def delete
    Application.remove(@part)
    @part = nil
  end

  def out_of_window?
    @part.x < 0 || @part.x + @width > GameModel.model['GAME']['WINDOW_WIDTH'] ||
      @part.y < 0 || @part.y + @width > GameModel.model['GAME']['WINDOW_HEIGHT']
  end

  def contains?(other)
    (@part.x >= other.x && @part.x <= other.x + other.width) || (@part.y >= other.y && @part.y <= other.y + other.height)
  end

end