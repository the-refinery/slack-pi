require 'serialport'

class Arduino

  def initialize
    @sp = SerialPort.new "/dev/ttyACM0", 9600
    @sp.read_timeout = 500
  end

  def pulse_color hex, pulse_times = 1
    bytes = parse_hex hex

    0.step(pulse_times - 1) do
      set_color bytes
    end

  end

  private

  def parse_hex hex

    unless hex[0] == "#"
      hex = "#" + hex
    end

    m = hex.match /#(..)(..)(..)/

    rgb = [m[1], m[2], m[3]].map {|x| x.hex.chr}
    rgb.join
  end

  def set_color color
    @sp.flush_input
    @sp.flush_output

    @sp.write color

    resp = @sp.readline("\n").chomp

    while resp != "DONE"
      print "#{resp}\n"
      resp = @sp.readline("\n").chomp
    end
  end

end
