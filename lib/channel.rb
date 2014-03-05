class Channel

  attr_reader :color

  def initialize slack, id, color
    @slack = slack
    @id = id
    @color = color
  end

  def poll
    messages = get_messages

    keyword_found = false

    messages.each do |message|
      unless message["text"].nil?
        text = message["text"].downcase

        @slack.keywords.each do |keyword|
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
    data = @slack.api_request "channels.history", {:channel => @id}
    data["messages"]
  end

end
