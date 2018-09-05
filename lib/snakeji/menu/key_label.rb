require_relative 'Base/button'

class KeyLabel < UIElement
  include Observable
  attr_accessor :selected
  BG_COLOR = '#454455'.freeze
  SELECTED_BORDER_COLOR = '#F9EC18'.freeze
  BORDER_WIDTH = GameModel.model['MENU']['KEY_LABEL_BORDER_WIDTH']

  def initialize(label_content, key_content, opts = {})
    @parent = opts[:parent]
    @width = @parent.width * 10.0 / 12.0
    @height = @parent.height * 1.0 / 8.0
    @label_content = label_content
    @key_content = key_content
    @selected = false
    super(@width, @height, opacity: 0, active: @parent.active)
    on_click
    on_key
  end

  def active
    @active = !@active
  end

  def create_label
    Button.new(@width * 4.0 / 7.0,
               @height,
               @label_content,
               bg_color: BG_COLOR,
               border_size: BORDER_WIDTH,
               border_color: BG_COLOR,
               selected_border_color: SELECTED_BORDER_COLOR)
  end

  def create_key
    Button.new(@width * 2.0 / 7.0,
               @height,
               @key_content,
               bg_color: BG_COLOR,
               border_size: BORDER_WIDTH,
               border_color: BG_COLOR,
               selected_border_color: SELECTED_BORDER_COLOR)
  end

  def unselect
    return false unless @selected
    @selected = false
    @key.change_border
    @label.change_border
  end

  def hide
    unselect
    active
  end

  def select
    @selected = !@selected
    @key.change_border
    @label.change_border
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)
    @label = create_label
    @key = create_key
    @label.draw(top_left_x, top_left_y)
    @key.draw(top_left_x + @width * 5.0 / 7.0, top_left_y)
  end

  def on_key
    Application.on :key_down do |e|
      if @selected && @active
        @key.text.text = e.key
        @key.center_text
      end
    end
  end

  def on_click
    Application.on :mouse_down do |e|
      if contains?(e.x, e.y) && @active
        if e.button == :left
          changed(true)
          notify_observers(self)
        end
      end
    end
  end

end