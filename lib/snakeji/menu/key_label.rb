require_relative '../../../lib/snakeji/utility/utility'
require_relative '../../../lib/snakeji/menu/button'
require_relative 'bounding_box'
class KeyLabel
  include Observable
  attr_accessor :selected
  def initialize(bounding_box, label_content, key_content, rect_color)
    @bounding_box = bounding_box
    @label_content = label_content
    @key_content = key_content
    @rect_color = rect_color
    @border_color = rect_color
    @border_width = GameModel.model['MENU']['KEY_LABEL_BORDER_WIDTH']
    @selected = false
    @active = true
    create_label
    create_key
    on_click
    on_key
  end

  def active
    @active = !@active
  end

  def create_label
    @label = BorderedButton.new(create_label_bounding_box,
                                text: @label_content,
                                border_width: 2,
                                border_color: @rect_color,
                                selected_border_color: '#F9EC18',
                                button_color: @rect_color)

  end

  def create_label_bounding_box
    label_width = @bounding_box.width * GameModel.get_ratio('KEY_LABEL_TEXT_WIDTH')
    BoundingBox.new(@bounding_box.top_left, label_width, @bounding_box.height)
  end

  def create_key_bounding_box
    key_label_x = @bounding_box.top_left.x + @bounding_box.width * GameModel.get_ratio('KEY_LABEL_KEY_X')
    BoundingBox.new(Point.new(key_label_x, @bounding_box.top_left.y),
                    @bounding_box.width * 2.0 / 7.0,
                    @bounding_box.height
    )
  end

  def create_key
    @key = BorderedButton.new(create_key_bounding_box,
                              text: @key_content,
                              border_width: 2,
                              border_color: @rect_color,
                              selected_border_color: '#F9EC18',
                              button_color: @rect_color)
  end

  def unselect
    return false unless @selected
    @selected = false
    @key.change_border
    @label.change_border
  end

  def on_key
    Application.on :key_down do |e|
      if @selected && @active
        @key.text.text = e.key
      end
    end
  end

  def on_click
    Application.on :mouse_down do |e|
      if e.button == :left
        if @bounding_box.contains?(Point.new(e.x, e.y)) && @active
          @selected = !@selected
          @key.change_border
          @label.change_border
          changed(true)
          notify_observers(self)
        end
      end
    end
  end

end