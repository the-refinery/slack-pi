require "net/http"
require "uri"
require "json"

class Channel

  attr_reader :color

  def initialize id, color
    @id = id
    @color = color
  end

  def poll keywords
    messages = get_messages

    keyword_found = false

    messages.each do |message|
      unless message["text"].nil?
        text = message["text"].downcase

        keywords.each do |keyword|
          if text.include? keyword.downcase
            keyword_found = true
          end
        end
      end
    end

    if keyword_found
      true
    end
  end

private

  def get_messages
    query = Array.new
    query << "token=#{SLACK_TOKEN}"
    query << "channel=#{@id}"

    uri = URI.parse("https://slack.com/api/channels.history")
    uri.query = query.join("&")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    data = JSON.parse(response.body)


    data["messages"]
  end

end
