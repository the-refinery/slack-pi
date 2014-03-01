require_relative 'lib/led'
require_relative 'lib/channel'
require_relative 'config/slack_config'

@board = {
  red:  Led.new("Red", 18),
  green:  Led.new("Green", 23),
  blue:  Led.new("Blue", 24),
  yellow:  Led.new("Yellow", 25)
}

@channels = {}

@monitored_channels.each_pair do |color, channel_id|
  @channels[channel_id] = Channel.new(channel_id, @board[color])
end

@channels.each_value do |channel|
  channel.poll
end

