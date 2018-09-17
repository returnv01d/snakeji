require_relative 'Base/button'

class KeyLabel < UIElement
  include Observable

  BG_COLOR = GameModel.model['MENU']['KEY_LABEL_BG_COLOR'].freeze
  SELECTED_BORDER_COLOR = GameModel.model['MENU']['KEY_LABEL_SELECTED_BORDER_COLOR'].freeze
  BORDER_WIDTH = GameModel.model['MENU']['KEY_LABEL_BORDER_WIDTH']

  attr_accessor :selected
  def initialize(label_content, key_content, opts = {})
    parent = opts[:parent]
    width = parent.width * 10.0 / 12.0
    height = parent.height * 1.0 / 8.0
    super(width, height, opacity: 0, active: parent.active)
    @label_content = label_content
    @key_content = key_content
    @selected = false
    @label = create_label
    @key = create_key
    on_click
    on_key
  end

  def show
    if @active
      @key.show ; @label.show
    else
      @key.hide ; @label.hide
    end
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
    show
  end

  def current_key
    @key.text.text
  end

  def key_label
    @label.text.text
  end

  def select
    @selected = !@selected
    @key.change_border
    @label.change_border
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)
    @label.draw(top_left_x, top_left_y)
    @key.draw(top_left_x + @width * 5.0 / 7.0, top_left_y)
    show
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