require_relative '../utility/string.rb'
require_relative '../utility/utility.rb'
require 'json'
CONFIG_FILE_PATH = 'config.json'

class GameModel
  attr_accessor :model
  def initialize
    @model = Utility::read_config_to_hash(CONFIG_FILE_PATH)
  end

  @@instance = GameModel.new
  def self.model
    @@instance.model
  end

  private_class_method :new
end