require_relative 'lib/led'
require_relative 'lib/arduino'
require_relative 'lib/slack'

@arduino = Arduino.new

@slack = Slack.new(Led.new("Yellow", 18))

while true do
  @slack.poll

  #we'll cycle the colors 3 times
  0.step(2) do
    @slack.notifications.each do |color|
      @arduino.pulse_color color
    end
  end

  #just to give Ctrl-C a faster effect
  0.step(9) do
    sleep 0.5
  end

end

