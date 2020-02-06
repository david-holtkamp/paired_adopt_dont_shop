class Favorites
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new
  end

  def add_pet(pet_info)
    @contents[pet_info[:id].to_s] ||= pet_info[:info]
  end

  def total_count
    @contents.length
  end
end
