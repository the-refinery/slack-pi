require_relative 'lib/led'
require_relative 'lib/arduino'
require_relative 'lib/slack'

@arduino = Arduino.new

@slack = Slack.new(Led.new("Yellow", 18))

@slack.poll

@slack.notifications.each do |color|
  @arduino.pulse_color color
end

