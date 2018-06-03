require_relative '../utility/string.rb'
require_relative '../utility/utility.rb'
require 'json'
CONFIG_FILE_PATH = 'config.json'

class GameModel
  attr_accessor :model
  def initialize
    @model = Utility::read_config_to_hash(CONFIG_FILE_PATH)
    @model['MENU']['RATIOS'].each { |_, value| value = value.to_r.to_f }
  end

  @@instance = GameModel.new
  def self.model
    @@instance.model
  end

  def self.get_ratio(name)
    @@instance.model['MENU']['RATIOS'][name].to_r.to_f
  end

  private_class_method :new
end