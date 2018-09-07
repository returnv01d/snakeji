require_relative 'Alignments/horizontal_alignment'
require_relative 'emojii'

EMOJII_PATHS = %w[smile sunglasses joy angery neutral robot].freeze

class EmojiiPanel < CompositeUIElement
  include Observable
  attr_accessor :parent
  def initialize(opts = {})
    parent = opts[:parent]
    height = parent.height * 1.0 / 6.0
    width = parent.width * 10.0 / 12.0
    super(width, height, active: parent.active, bg_color: parent.bg_color)
  end

  def draw(top_left_x, top_left_y)
    create_sub_elements

    element_width = @sub_elements[1].width
    available_space = @width - element_width * @sub_elements.count
    element_spacing = element_width + available_space * 1.0 / (@sub_elements.count - 1)

    alignment = HorizontalAlignment.new(@sub_elements, element_spacing)
    alignment.draw(top_left_x, top_left_y + 10)
  end

  def create_sub_elements
    EMOJII_PATHS.each do |path|
      emojii = Emojii.new(path, parent: self)
      emojii.add_observer(self, :on_emojii_click)
      @sub_elements << emojii
    end
  end

  def hide
    @sub_elements.each{ |emojii| emojii.unselect; emojii.active; }
  end

  def on_emojii_click (emojii)
    emojii_pos = @sub_elements.find_index(emojii)
    changed(true)
    notify_observers(self, emojii_pos)
  end

  def unselect_each
    @sub_elements.each(&:unselect)
  end

  def change_emojii_at(index, func)
    @sub_elements[index].send(func)
  end

  def has_selected_emojii?
    @sub_elements.any?(&:selected)
  end

  def selected_emojii_index
    selected_emojii = @sub_elements.select(&:selected)
    @sub_elements.find_index(selected_emojii[0])
  end
end