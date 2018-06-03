require_relative '../../../lib/snakeji/utility/utility'
class KeyLabel
  def initialize(bounding_box, label_content, key_content, rect_color)
    @bounding_box = bounding_box
    @label_content = label_content
    @key_content = key_content
    @rect_color = rect_color
    create_label_text
    create_key_text
  end

  def create_label_text
    create_label_rect
    @label_text = create_text(@label_rect.x  + @label_rect.width / 2.0,
                              @bounding_box.top_left.y + (@bounding_box.height / 2),
                              @label_content, 15)
  end

  def create_label_rect
    label_width = @bounding_box.width * GameModel.get_ratio('KEY_LABEL_TEXT_WIDTH')
    @label_rect = Rectangle.new(x: @bounding_box.top_left.x,
                                y: @bounding_box.top_left.y,
                                width: label_width,
                                height: @bounding_box.height,
                                color: @rect_color)
    @label_rect.add
  end

  def create_key_text
    create_key_rect
    @key_text = create_text(@key_rect.x + @key_rect.width / 2.0,
                            @bounding_box.top_left.y + (@bounding_box.height / 2),
                            @key_content, 15)
  end

  def create_key_rect
    key_label_x = @bounding_box.top_left.x + @bounding_box.width * GameModel.get_ratio('KEY_LABEL_KEY_X')
    @key_rect = Rectangle.new(
      x: key_label_x,
      y: @bounding_box.top_left.y,
      width: @bounding_box.width * 2.0 / 7.0,
      height: @bounding_box.height,
      color: @rect_color
    )
    @key_rect.add
  end

  def create_text(x, y, content, text_size)
    text = Text.new(x: x,
                    y: y,
                    text: content,
                    font: '../../fonts/Vera.ttf',
                    size: text_size)
    Utility.center_text(text)
    text.add
    text
  end
end