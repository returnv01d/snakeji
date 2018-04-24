require_relative '../utility/utility'

PLAYER_MODEL_FILE_PATH = 'player_model.txt'
class PlayerModel
  def initialize
    @model = Hash.new
    @model = Utility::read_config_to_hash(PLAYER_MODEL_FILE_PATH)
  end

  def get (something)
    @model[something.to_sym]
  end

  def set (what, value)
    @model[what.to_sym] = value
  end
end