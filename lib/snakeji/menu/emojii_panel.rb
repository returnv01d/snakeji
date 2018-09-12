require_relative 'Alignments/horizontal_alignment'
require_relative 'emojii'

EMOJII_PATHS = %w[smile sunglasses joy angery neutral robot].freeze

class EmojiiPanel < CompositeUIElement
  include Observable
  attr_accessor :parent, :selected_emojii_poss
  def initialize(opts = {})
    parent = opts[:parent]
    height = parent.height * 1.0 / 6.0
    width = parent.width * 10.0 / 12.0
    super(width, height, active: parent.active, bg_color: parent.bg_color)
    @selected_emojii_pos = nil
  end

  def draw(top_left_x, top_left_y)
    create_sub_elements

    element_width = @sub_elements[1].width
    available_space = @width - element_width * @sub_elements.count
    element_spacing =  available_space * 1.0 / (@sub_elements.count - 1)

    alignment = HorizontalAlignment.new(@sub_elements, element_spacing)
    alignment.draw(top_left_x, top_left_y )
  end

  def create_sub_elements
    EMOJII_PATHS.each do |path|
      emojii = Emojii.new(path, parent: self)
      emojii.add_observer(self, :on_emojii_click)
      @sub_elements << emojii
    end
  end

  def hide
    @sub_elements.each(&:active)
    @selected_emojii_pos = nil
  end

  def selected_emojii_pos=(emojii_pos)
    unless @selected_emojii_pos.nil?
      @sub_elements[@selected_emojii_pos].unselect
    end

    @selected_emojii_pos = emojii_pos

    unless emojii_pos.nil?
      @sub_elements[emojii_pos].select
    end
  end

  def on_emojii_click (emojii)
    emojii_pos = @sub_elements.find_index(emojii)
    changed(true)
    notify_observers(self, emojii_pos)
  end

  def change_emojii_at(index, func)
    @sub_elements[index].send(func)
  end

  def selected_emojii_pos
    @selected_emojii_pos
  end
end