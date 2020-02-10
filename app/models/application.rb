class Application < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description
  has_many :application_pets
  has_many :pets, through: :application_pets

  def approved_for_pet(pet)
    application_pets.find_by(pet_id: pet.id).approved
  end
end
