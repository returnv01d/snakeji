require 'ruby2d'
require 'snakeji/models/game_model'
require 'snakeji/menu/button_panel'
require 'snakeji/menu/main_panel'
require 'snakeji/menu/bottom_button'
require 'snakeji/menu/message_box'

class Menu
  attr_accessor :height_padding
  include Observable
  def initialize
    @width = GameModel.model['MENU']['WINDOW_WIDTH']
    @height = GameModel.model['MENU']['WINDOW_HEIGHT']
    @bg_color = GameModel.model['MENU']['BG_COLOR']
    
    @width_padding = @width * 1.0 / 32.0
    @height_padding = @height * 1.0 / 32.0

    Application.set(title: 'snake', width: @width, height: @height, background: @bg_color)

    create_view
    show!
  end


  def create_view
    create_button_panel
    create_main_panel
  end

  def create_main_panel
    @main_panel = MainPanel.new(parent: self)
  end

  def create_button_panel
    @button_panel = ButtonPanel.new(parent: self)
    @button_panel.start_button.add_observer(self, :on_start_button_click)
  end

  def activate_start_button
    @button_panel.start_button.activate
  end

  def on_start_button_click
    @button_panel.start_button.deactivate

    number_of_players = @main_panel.active_panels_count
    return unless check_number_of_players number_of_players

    window_width = @button_panel.current_resolution_width
    window_height = @button_panel.current_resolution_height

    players_keys = @main_panel.players_keys
    players_emojiis = @main_panel.players_emojiis
    if players_emojiis.compact.length < number_of_players
      create_message_box('No emojii selected in panel! Will use default one :(')
    end

    start_game(window_width, window_height, number_of_players, players_keys, players_emojiis)
  end

  def check_number_of_players (number_of_players)
    if number_of_players.zero?
      create_message_box('There must be at least one player!')
      return false
    end

    true
  end

  def show!
    draw(0, 0)
    Application.show
  end

  def draw(top_left_x, top_left_y)
    elements = [@main_panel, @button_panel]
    VerticalAlignment.new(elements, 0)
        .draw(top_left_x, top_left_y + @height_padding)
  end

  def start_game(window_width, window_height, number_of_players, players_keys, players_emojiis)
    @main_panel = nil
    @button_panel = nil

    Application.close
    Thread.new {
      system('ruby', 'game/game.rb',
      window_width.to_s, window_height.to_s,
      number_of_players.to_s,
      players_keys.to_s, players_emojiis.to_s)
    }

    sleep 1
    exit! 0
  end

  def create_message_box(message)
    mb = MessageBox.new(message)
    mb.add_observer(self, :activate_start_button)
    mb.show
  end
end

Menu.new