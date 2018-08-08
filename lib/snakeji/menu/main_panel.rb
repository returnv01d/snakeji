require_relative 'panel'
require_relative 'key_panel'

class MainPanel < CompositeUIElement

  WIDTH = GameModel.model['WINDOW_WIDTH']
  HEIGHT = GameModel.model['WINDOW_HEIGHT'] * 5.0 / 6.0
  BG_COLOR = GameModel.model['MENU']['BG_COLOR']

  def initialize()
    super(WIDTH, HEIGHT, bg_color: BG_COLOR)
    @width_padding = GameModel.get_ratio('MAIN_PANEL_WIDTH_PADDING') * WIDTH
    @height_padding = GameModel.get_ratio('MAIN_PANEL_HEIGHT_PADDING') * HEIGHT
    @player_panel_color = GameModel.model['MENU']['PLAYER_PANEL_COLOR']
    @key_labels = []
    #create_panels
    observe
  end

  def create_panel(width_step, height_step)
    panel = KeyPanel.new(parent: self)
    panel_x = @x + width_step * (@width / 2.0) + @width_padding
    panel_y = @y + height_step * (@height / 2.0) + @height_padding
    panel.draw(panel_x, panel_y)
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

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)
    2.times do |height_step|
      2.times do |width_step|
        create_panel(height_step, width_step)
      end
    end
    end
end