require_relative '../utility/string.rb'
require_relative '../utility/utility.rb'
require 'json'
CONFIG_FILE_PATH = 'config.json'

class GameModel
  def initialize
    @model = Utility::read_config_to_hash(CONFIG_FILE_PATH)
  end

  @@instance = GameModel.new
  def self.instance
    @@instance
  end

  def get (something)
    @model[something.to_s]
  end

  def set (what, value)
    @model[what.to_s] = value
  end
  private_class_method :new
end