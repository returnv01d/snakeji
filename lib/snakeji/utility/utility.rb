require 'json'

module Utility
  def self.read_config_to_hash(file_path)
    data = File.read(file_path)
    hash = JSON.parse(data)
    hash
  end

  def self.center_text(text)
    text.x -= text.width / 2.0
    text.y -= text.height / 2.0
    text
  end

  def self.distance_between_two_points(x1, y1, x2, y2)
    Math.sqrt(((x1 - x2)**2) + ((y1 - y2)**2))
  end
end