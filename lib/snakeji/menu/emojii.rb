require_relative 'Decorators/border_decoration'
require_relative '../../../lib/snakeji/menu/Base/button'

class Emojii < UIElement
  include Observable

  INACTIVE_BG_COLOR = GameModel.model['MENU']['KEY_PANEL_INACTIVE_BG_COLOR']
  BORDER_COLOR = GameModel.model['MENU']['KEY_PANEL_BG_COLOR'].freeze
  SELECTED_BORDER_COLOR = GameModel.model['MENU']['EMOJII_SELECTED_BORDER_COLOR'].freeze
  STARTING_OPACITY = 0.85.freeze

  attr_accessor :selected, :gray_out, :deactivated
  attr_reader :path
  def initialize(emojii_path, opts = {})
    parent = opts[:parent]
    height = parent.height - 5
    width  = height
    super(width, height, active: parent.active, parent: parent)
    @path = emojii_path
    @selected = false
    @deactivated = false
    on_click
  end

  def create_emojii
    @emojii = Image.new(path: "../../assets/emojis/#{@path}.png",
                        width: @width, height: @height)
    @emojii.opacity = STARTING_OPACITY
  end

  def create_border
    Button.new(@width + 10,
               @height + 10,
               '',
               border_color: BORDER_COLOR,
               bg_color: BORDER_COLOR,
               selected_border_color: SELECTED_BORDER_COLOR,
               border_size: 3)
  end

  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)

    @border = create_border
    @border.draw(top_left_x - 5, top_left_y - 5)

    create_emojii
    @emojii.x = top_left_x
    @emojii.y = top_left_y

    change_visibility
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
      @border.rect.color = INACTIVE_BG_COLOR
      @border.border.color = INACTIVE_BG_COLOR
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
      if @emojii.contains?(e.x, e.y) && @active
          unless deactivated
            changed(true)
            notify_observers(self)
          end
      end
    end
  end

  def deactivate
    @emojii.opacity = 0.3
    @deactivated = true
    #@emojii.color = '#909090'
  end

  def activate
    @emojii.opacity = STARTING_OPACITY
    @deactivated = false
    #@emojii.color = '#ffffff'
  end
end