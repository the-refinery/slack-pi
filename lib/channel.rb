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
    params = {:channel => @id}

    unless @latest.nil?
      params[:oldest] = @latest
      params[:count] = 300
    end

    data = @slack.api_request "channels.history", params

    if data["messages"].count > 0
      @latest = data["messages"].first["ts"]
    end

    puts "#{@id}: #{data["messages"].count}, #{@latest}"

    data["messages"]
  end

end
