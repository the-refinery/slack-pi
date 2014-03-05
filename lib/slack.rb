require_relative '../config/slack_config'
require_relative './channel'
require_relative './user'

class Slack

  attr_reader :notifications

  def initialize led
    @led = led
    setup_channels
    setup_keywords

  end

  def poll
    @notifications = []

    @channels.each_value do |channel|
      @led.blink

      notify = channel.poll @keywords

      if notify
        @notifications << channel.color
      end
    end
  end

private

  def setup_channels
    @channels = {}

    MONITORED_CHANNELS.each_pair do |channel_id, color|
      @channels[channel_id] = Channel.new(channel_id, color)
    end
  end

  def setup_keywords
    @keywords = KEYWORDS
  end

end
