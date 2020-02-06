class Favorites
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new
  end

  def add_pet(id)
    @contents << id.to_s if !@contents.include?(id.to_s)
  end

  def total_count
    @contents.length
  end
end
