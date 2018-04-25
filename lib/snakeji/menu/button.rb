require 'ruby2d'
require_relative 'basic_control'
class BorderedButton < BasicControl
  def initialize(border_radius, border_color, text)
    @border_radius = border_radius
    @border_color = border_color
    @text = text
  end
end