require 'pipiper'
include PiPiper

class Led
  attr_reader :name,
              :pin

  def initialize name, pin_number
    @name = name
    pin = PiPiper::Pin.new(pin: pin_number, direction: :out)
  end

  def on
    pin.on
  end

  def off
    pin.off
  end
end
