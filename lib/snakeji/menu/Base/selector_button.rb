require_relative '../Alignments/horizontal_alignment'

class SelectorButton < CompositeUIElement
  BG_COLOR = GameModel.model['MENU']['BG_COLOR']
  def initialize(width, height, opts = {})
    super(width, height, bg_color: BG_COLOR)
    @text_options = opts[:text_options]
    @options_iterator = 0
    on_click
  end

  def create_sub_elements
    arrow_width = @height * 11.0 / 20.0

    @left_arrow = Image.new(
      x: @x,
      y: @y + arrow_width / 2.0,
      width: arrow_width,
      height: arrow_width,
      color: BG_COLOR,
      path: '../../assets/left_arrow.png'
    )

    @right_arrow = Image.new(
      x: @x + @width - arrow_width,
      y: @y + arrow_width / 2.0,
      width: arrow_width,
      height: arrow_width,
      color: BG_COLOR,
      path: '../../assets/right_arrow.png'
    )

    @text = Text.new(x: @x,
                     y: @y,
                     text: @text_options[0],
                     font: '../../fonts/Vera.ttf',
                     color: '#5680E9',
                     size: 18)


    center_text
  end

  def center_text
    @text.y = @y + @height / 2.0 - @text.height / 2.0 # center vertically

    available_text_space = @width - (@left_arrow.width + @right_arrow.width)
    text_offset = available_text_space - @text.width
    @text.x = @x + @left_arrow.width + (text_offset / 2.0) # center horizontally
  end


  def draw(top_left_x, top_left_y)
    super(top_left_x, top_left_y)
    create_sub_elements
  end

  def on_click
    Application.on :mouse_down do |e|
      if @left_arrow.contains?(e.x, e.y)
        @options_iterator += 1
        @text.text = @text_options[current_text_pos]
      elsif @right_arrow.contains?(e.x, e.y)
        @options_iterator -= 1
        @text.text = @text_options[current_text_pos]
      end

      center_text
    end
  end

  def current_text_pos
    @options_iterator % @text_options.size
  end

  def current_option
    @text_options[current_text_pos]
  end
end