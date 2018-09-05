require_relative 'horizontal_alignment'
require_relative 'vertical_alignment'

class TableAlignment
  def initialize(elements, num_of_elements_in_row, elements_spacing, row_spacing)
    @elements = elements
    @num_of_elements_in_row = num_of_elements_in_row
    @elements_spacing = elements_spacing
    @row_spacing = row_spacing
  end

  def draw(top_left_x, top_left_y)
    vertical_alignment = VerticalAlignment.new(create_rows, @row_spacing)
    vertical_alignment.draw(top_left_x, top_left_y)
  end

  def create_rows
    rows = []

    row_elements = @elements.each_slice(@num_of_elements_in_row)
    row_elements.each do |row|
      rows << HorizontalAlignment.new(row, @elements_spacing)
    end

    rows
  end
end