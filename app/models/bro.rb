class Bro
  attr_accessor :name, :job, :bio, :fav_food, :id

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
end