class Alignment
  def initialize(elements, num_of_rows, num_of_columns, opts = {})
    @elements = elements
    @height_spacing = opts[:height_spacing] || 20
    @width_spacing = opts[:width_spacing| || 20
    @num_of_columns = num_of_columns
    @num_of_rows = num_of_rows
  end

  def render(top_left_x, top_left_y)
    @num_of_columns.times do |height_step|
      @num_of_rows.times do |width_step|
        create_panel(create_panel_point(height_step, width_step))
      end
  end
end