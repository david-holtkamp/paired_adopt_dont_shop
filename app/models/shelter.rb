class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy 

  def pet_count(status = 'all')
    return pets.count if status == 'all'
    return pets.where(status: status).count if status != 'all'
  end
end
