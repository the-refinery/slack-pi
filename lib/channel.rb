require "net/http"
require "uri"
require "json"

class Channel

  def initialize id, led
    @id = id
    @led = led
  end

  def notify
    @led.blink
  end

end
