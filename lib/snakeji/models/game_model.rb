require_relative 'player_model'
require_relative '../utility/string.rb'
require_relative '../utility/utility.rb'

CONFIG_FILE_PATH = 'config.txt'

class GameModel
  attr_reader :player_models
  def initialize
    @model = Hash.new
    @model = Utility::read_config_to_hash(CONFIG_FILE_PATH)
    @player_models = Array.new
    Integer(@model[:NUMBER_OF_PLAYERS]).times { @player_models << PlayerModel.new }
  end

  @@instance = GameModel.new
  def self.instance
    @@instance
  end

  def get (something)
    @model[something.to_sym]
  end

  def set (what, value)
    @model[what.to_sym] = value
  end
  private_class_method :new
end