require_relative 'Base/button'
class BottomButton < Button

  BG_COLOR = GameModel.model['MENU']['BOTTOM_BUTTON_BG_COLOR']
  BORDER_COLOR = GameModel.model['MENU']['BOTTOM_BUTTON_BORDER_COLOR']
  TEXT = GameModel.model['MENU']['BOTTOM_BUTTON_TEXT']

  def initialize
    width = GameModel.model['WINDOW_WIDTH'] * (1.0 / 16.0)
    height = GameModel.model['WINDOW_HEIGHT'] * (1.0 / 16.0)
    super(width, height, TEXT, bg_color: BG_COLOR, border_color: BORDER_COLOR)
  end

end