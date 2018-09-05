require_relative 'Decorators/border_decoration'
require_relative '../../../lib/snakeji/menu/Base/button'

INACTIVE_COLOR = '#696969'.freeze
BORDER_COLOR = GameModel.model['MENU']['PLAYER_PANEL_COLOR'].freeze
SELECTED_BORDER_COLOR = '#D3D3D3'.freeze

class Emojii < UIElement
  include Observable

  attr_accessor :selected, :gray_out
  def initialize(emojii_path, opts = {})
    @emojii_path = emojii_path
    @parent = opts[:parent]
    @height = @parent.height - 5
    @width  = @height
    super(@width, @height, active: @parent.active, parent: @parent)
    @selected = false
    on_click
  end

  def create_emojii
    @emojii = Image.new(path: "../../assets/emojis/#{@emojii_path}.png",
                        width: @width, height: @height)
    change_visibility
  end

  def create_border
    Button.new(@width +10,
               @height+ 10,
               '',
               border_color: BORDER_COLOR,
               bg_color: BORDER_COLOR,
               selected_border_color: SELECTED_BORDER_COLOR,
               border_size: 3)
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)

    @border = create_border
    @border.draw(top_left_x - (10.0 / 2.0), top_left_y - (10 / 2.0))

    create_emojii
    @emojii.x = top_left_x
    @emojii.y = top_left_y

  end

  def active
    @active = !@active
    change_visibility
  end

  def change_visibility
    if @active
      Application.add(@emojii)
      @border.rect.color = BORDER_COLOR
      @border.border.color = BORDER_COLOR
    else
      @border.rect.color = INACTIVE_COLOR
      @border.border.color = INACTIVE_COLOR
      Application.remove(@emojii)
    end
  end

  def unselect
    if @selected
      select
    end
  end

  def select
    @selected = !@selected
    @border.change_border
  end

  def on_click
    Application.on :mouse_up do |e|
      if @emojii.contains?(e.x, e.y)
        changed(true)
        notify_observers(self)
      end
    end
  end

  def deactivate
    @emojii.opacity = 0.3
    @emojii.color = '#909090'
  end

  def activate
    @emojii.opacity = 1.0
    @emojii.color = '#ffffff'
  end
end