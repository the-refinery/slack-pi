require "net/http"
require "uri"
require "json"

require_relative '../config/slack_config'
require_relative './channel'
require_relative './user'

class Slack

  attr_reader :notifications,
              :keywords

  def initialize led
    @led = led
    setup_channels
    setup_users
    setup_keywords

  end

  def poll
    @notifications = []

    @channels.each_value do |channel|
      @led.blink

      notify = channel.poll

      if notify
        @notifications << channel.color
      end
    end
  end

  def api_request method, params={}
    params[:token] = SLACK_TOKEN

    query = Array.new
    params.each_pair do |key, value|
      query << "#{key.to_s}=#{value}"
    end

    uri = URI.parse("https://slack.com/api/#{method}")
    uri.query = query.join("&")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    JSON.parse(response.body)
  end

private

  def setup_channels
    @channels = {}

    MONITORED_CHANNELS.each_pair do |channel_id, color|
      @channels[channel_id] = Channel.new(self, channel_id, color)
    end
  end

  def setup_users
    @led.blink 2

    @users = []

    data = api_request("users.list")["members"]

    data.each do |member|
      user = User.new member
      @users << user
    end
  end

  def setup_keywords
    @keywords = KEYWORDS

    @users.each do |user|
      if user.matches_keywords(KEYWORDS)
        @keywords << "<@#{user.id}>"
      end
    end

    puts "Searching for: [#{@keywords.join(", ")}]"
  end

end
