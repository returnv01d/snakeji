require_relative 'Base/button'
class BottomButton < Button
  include Observable
  BG_COLOR = GameModel.model['MENU']['BOTTOM_BUTTON_BG_COLOR']
  INACTIVE_BG_COLOR = GameModel.model['MENU']['BOTTOM_BUTTON_INACTIVE_BG_COLOR']
  TEXT = GameModel.model['MENU']['BOTTOM_BUTTON_TEXT']

  def initialize
    width = GameModel.model['WINDOW_WIDTH'] * (1.0 / 10.0)
    height = GameModel.model['WINDOW_HEIGHT'] * (1.0 / 16.0)
    text_size = 18
    super(width, height, TEXT, bg_color: BG_COLOR, border_color: BG_COLOR, text_size: text_size)
    on_mouse_move
    on_click
  end

  def on_mouse_move
    Application.on :mouse_move do |e|
      if contains?(e.x, e.y)
        @border.color = BG_COLOR
        @rect.color = BG_COLOR
      else
        @rect.color = INACTIVE_BG_COLOR
        @border.color = INACTIVE_BG_COLOR
      end
    end
  end

  def on_click
    Application.on :mouse_down do |e|
      if contains?(e.x, e.y) && @active
        changed(true)
        notify_observers
      end
    end
  end

  def deactivate
    @active = false
  end

  def activate
    @active = true
  end

end