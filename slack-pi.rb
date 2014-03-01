require_relative 'lib/led'

def flip led
  if led.on?
    led.off
  else
    led.on
  end

  sleep 0.1
end

red = Led.new "Red", 18
green = Led.new "Green", 23
blue = Led.new "Blue", 24
yellow = Led.new "Yellow", 25

0.step(11) do
  flip red
  flip green
  flip blue
  flip yellow

  sleep 0.5
end
