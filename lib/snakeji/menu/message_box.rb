require_relative '../menu/Base/button'
require 'timeout'

class MessageBox
  include Observable

  MB_WIDTH = GameModel.model['WINDOW_WIDTH'] / 3.0
  MB_HEIGHT = GameModel.model['WINDOW_HEIGHT'] / 6.0
  MB_BG_COLOR = GameModel.model['MENU']['MB_BG_COLOR']
  MB_BORDER_COLOR = GameModel.model['MENU']['MB_BORDER_COLOR']
  BUTTON_WIDTH = MB_WIDTH / 3.0
  BUTTON_HEIGHT = MB_HEIGHT / 4.0

  def initialize (message_text)
    @message_text = message_text
    on_click
  end

  def show
    @rect = create_message_box
    @button = create_button
    draw_message_box
    draw_button
  end

  def create_message_box
    Button.new(MB_WIDTH,
               MB_HEIGHT,
               @message_text,
               bg_color: MB_BG_COLOR,
               border_color: MB_BORDER_COLOR,
               z: 1)
  end

  def create_button
    Button.new(BUTTON_WIDTH,
               BUTTON_HEIGHT,
               'Oh no!',
               bg_color: MB_BG_COLOR,
               border_color: MB_BG_COLOR,
               text_color: 'black',
               text_size: 17,
               z: 1)
  end

  def draw_message_box
    mb_center_x = GameModel.model['WINDOW_WIDTH'] / 2.0 - MB_WIDTH / 2.0
    mb_center_y = GameModel.model['WINDOW_HEIGHT'] / 2.0 - MB_HEIGHT / 2.0
    @rect.draw(mb_center_x, mb_center_y)
  end

  def draw_button
    button_center_x = @rect.x + (@rect.width / 2.0) - @button.width / 2.0
    button_y =  @rect.y + @rect.height - (@button.height * 12 / 10)
    @button.draw(button_center_x, button_y )
  end

  def on_click
    on_click_event = Application.on :mouse_up do |e|
      if @button.contains?(e.x, e.y)
        changed true
        notify_observers
        @rect.remove
        @button.remove
        @rect = nil
        @button = nil
        Application.off(on_click_event)
      end
    end
  end

end