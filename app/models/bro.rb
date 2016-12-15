class Bro
  attr_accessor :name, :job, :bio, :fav_food, :id

  # STATIC METHODS (Class methods)
  def self.find_by_id(id)
    unirest_response = Unirest.get("#{ENV['API_URL']}/bros/#{id}.json").body
    return Bro.new(unirest_response)
  end

  def self.get_all
    unirest_data = Unirest.get("#{ENV['API_URL']}/bros.json").body
    bros = Array.new
    unirest_data.each do |data_hash|
      bros.push(Bro.new(data_hash))
    end
    return bros
  end

  ## Private Methods
  # Constructor
  def initialize(input_hash)
    unless input_hash['info']
      make_index_bro(input_hash)
    else
      make_bro(input_hash)
    end
  end

  def make_index_bro(input_hash)
    @id = input_hash['id']
    @name = input_hash['name']
    @job = input_hash['job']
    @bio = input_hash['bio']
    @fav_food = input_hash['fav_food']
  end

  def make_bro(input_hash)
    @id = input_hash['id']
    @name = input_hash['name']
    @job = input_hash['info']['job']
    @bio = input_hash['info']['bio']
    @fav_food = input_hash['info']['fav_food']
  end



  ## Public Instance Methods
  def to_json
    return json_data = { name: @name,job: @job,bio: @bio, fav_food: @fav_food }
  end

  def sync
    raise unless @id 
    return response = Unirest.patch("#{ENV['API_URL']}/bros/#{@id}",
      headers:{"Accept" => "application/json"},
      parameters: self.to_json
    )
  end

  def update(input_hash)
    raise unless @id 
    @name = input_hash[:name]
    @bio = input_hash[:bio]
    @fav_food = input_hash[:fav_food]
    @job = input_hash[:job]
    return response = self.sync
  end

  def post 
    return response = Unirest.post("#{ENV['API_URL']}/bros/",
      headers:{"Accept" => "application/json"},
      parameters: self.to_json)
  end

  def destroy
    raise unless @id 
    return response = Unirest.delete("#{ENV['API_URL']}/bros/#{@id}")
  end
end