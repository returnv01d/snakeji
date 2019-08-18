require 'json'

require 'snakeji/game/game'

class Runner

end

window_width = 800
window_height = 640
player_keys_string = '[{"UP":"w","DOWN":"s","LEFT":"a","RIGHT":"d"},{"UP":"up","DOWN":"down","LEFT":"left","RIGHT":"right"}]'
player_keys = JSON.parse(player_keys_string)
player_emojiis = JSON.parse('["smile", "sunglasses"]')
Game.new(window_width, window_height,   1, player_keys, player_emojiis).show!
#Game.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3], ARGV[4])