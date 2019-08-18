class Apple
  def initialize
    @width = (GameModel.model['GAME']['WINDOW_WIDTH'] * 1.0 / 32.0)
    @apple = Image.new(path: "#{$LOAD_PATH[0]}/../assets/apple.png",
                            width: @width, height: @width, z: 1)
  end

  def draw(x, y)
    @apple.x = x
    @apple.y = y
    Application.add(@apple)
  end

  def remove
    Application.remove(@apple)
    @apple = nil
  end
end