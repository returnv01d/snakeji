require_relative 'string.rb'
module Utility
  def self.read_config_to_hash(filepath)
    result = Hash.new
    File.open(filepath, "r") do |f|
      f.each_line do |line|
        line = line.split(" ")
        if line[1].numeric?
          line[1] = line[1].to_f
        end
        result[line[0].to_sym]=line[1]
      end
    end
    result
  end

  def self.center_text(text)
    text.x -= text.width / 2.0
    text.y -= text.height / 2.0
    text
  end
end