
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
end