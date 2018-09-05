require_relative 'Base/button'
class BottomButton < Button

  BORDER_COLOR = GameModel.model['MENU']['BOTTOM_BUTTON_BORDER_COLOR']

  def initialize
    @width = GameModel.model['WINDOW_WIDTH'] * (1.0 / 16.0)
    @height = GameModel.model['WINDOW_HEIGHT'] * (1.0 / 16.0)
    @bg_color = GameModel.model['MENU']['BOTTOM_BUTTON_COLOR']
    @text = GameModel.model['MENU']['BOTTOM_BUTTON_TEXT']
    super(@width, @height, @text, bg_color: @bg_color, border_color: BORDER_COLOR)
  end

end