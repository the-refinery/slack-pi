class User

  attr_reader :id,
              :name,
              :first_name,
              :last_name,
              :real_name

  def initialize data_hash
    @id = data_hash["id"]
    @name = data_hash["name"]
    @first_name = data_hash["profile"]["first_name"]
    @last_name = data_hash["profile"]["last_name"]
    @real_name = data_hash["profile"]["real_name"]
  end

  def matches_keywords keywords

    found = false

    keywords.each do |keyword|
      if @name && @name.include?(keyword)
        found = true
      end

      if @first_name && @first_name.include?(keyword)
        found = true
      end

      if @last_name && @last_name.include?(keyword)
        found = true
      end

      if @real_name && @real_name.include?(keyword)
        found = true
      end
    end

    found
  end

end
