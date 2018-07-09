require_relative 'panel'
require_relative 'key_panel'

class MainPanel < Panel
  def initialize(bounding_box, color)
    super(bounding_box, color)
    @width_padding = GameModel.get_ratio('MAIN_PANEL_WIDTH_PADDING') * @bounding_box.width
    @height_padding = GameModel.get_ratio('MAIN_PANEL_HEIGHT_PADDING') * @bounding_box.height
    @player_panel_color = GameModel.model['MENU']['PLAYER_PANEL_COLOR']
    @key_labels = []
    create_panels
    observe
  end

  def create_panels
    2.times do |height_step|
      2.times do |width_step|
        create_panel(create_panel_point(height_step, width_step), true)
      end
    end
  end

  def create_panel_point(height_step, width_step)
    Point.new(
        @bounding_box.top_left.x + width_step * (@bounding_box.width / 2.0) + @width_padding,
        @bounding_box.top_left.y + height_step * (@bounding_box.height / 2.0 + @height_padding)
    )
  end

  def create_panel(offset_point, active)
    bounding_box = BoundingBox.new(
        offset_point,
        @bounding_box.width / 2.0 - 2 * @width_padding,
        @bounding_box.height / 2.0 - @height_padding
    )
    panel = KeyPanel.new(bounding_box,
                         active: active,
                         active_color: @player_panel_color
    )
    @key_labels += panel.key_labels
    panel.on_click
  end

  def observe
    @key_labels.each{|label| label.add_observer(self) }
  end

  def update key_label
    @key_labels -= [key_label]
    @key_labels.each(&:unselect)
    @key_labels << key_label

  end
end