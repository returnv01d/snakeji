require_relative '../menu/Base/selector_button'

class ResolutionSelectorButton < SelectorButton

  RESOLUTIONS = ['800x600', '420x360', '1336x1187'].freeze

  def initialize
    width = GameModel.model['WINDOW_WIDTH'] * (1.0 / 5.0)
    height = GameModel.model['WINDOW_HEIGHT'] * (1.0 / 16.0)
    super(width, height, text_options: RESOLUTIONS)
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)
  end
end