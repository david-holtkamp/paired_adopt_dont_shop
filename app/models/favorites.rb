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

  def delete_pet(id)
    @contents.delete(id.to_s)
  end

  def delete_pets(pet_ids)
    pet_ids.each { |pet_id| delete_pet(pet_id) }
  end

  def refresh(pets)
    @contents = pets.map {|id| id.to_s }
  end

  def reset
    @contents = Array.new
  end
end
