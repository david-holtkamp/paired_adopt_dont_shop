class Favorites
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Array.new
  end

  def add_pet(id)
    @contents << id if !@contents.include?(id)
  end

  def total_count
    @contents.length
  end
end
