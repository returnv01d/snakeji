require_relative 'button'
class ButtonPanel
  def initialize(bounding_box, color)
    @bounding_box = bounding_box
    @color = color
    @button_width = @bounding_box.width * GameModel.get_ratio('BUTTON_PANEL_BUTTON_WIDTH')
    @button_height = @bounding_box.height * GameModel.get_ratio('BUTTON_PANEL_BUTTON_HEIGHT')
    create_panel
    create_button

  end

  def create_panel
    @panel = Panel.new(@bounding_box, @color)
  end

  def create_button
    @button = BorderedButton.new(create_button_bounding_box,
                                 text: 'Go!',
                                 border_width: 2,
                                 border_color: '#000000',
                                 button_color: '#777777',
                                 text_size: 20)
  end

  def create_button_bounding_box
    button_bounding_box = BoundingBox.new(create_button_top_left_point,
                                          @button_width,
                                          @button_height)
    button_bounding_box
  end

  def create_button_top_left_point
    top_left_point = Point.new(
        (@bounding_box.top_left.x + @bounding_box.width / 2.0) - @button_width / 2.0,
        (@bounding_box.top_left.y + @bounding_box.height / 2.0) - @button_height / 2.0)
    top_left_point
  end

end