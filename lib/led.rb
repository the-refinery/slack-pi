require 'pi_piper'
include PiPiper

class Led
  attr_reader :name,
              :pin

  def initialize name, pin_number
    @name = name
    @pin = PiPiper::Pin.new(pin: pin_number, direction: :out)
  end

  def on
    @pin.on
  end

  def off
    @pin.off
  end

  def toggle
    if off?
      on
    else
      off
    end
  end

  def on?
    @pin.read
    @pin.on?
  end

  def off?
    @pin.read
    @pin.off?
  end
end
