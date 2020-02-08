class Pet < ApplicationRecord
  validates_presence_of :image, :name, :description, :age, :sex, :status
  belongs_to :shelter
  has_many :application_pets
  has_many :applications, through: :application_pets

  def self.sort_by_status
    Pet.order(:status)
  end

  def self.adoptable
    Pet.where(status: "Adoptable")
  end

  def self.pending
    Pet.where(status: "Pending")
  end
end
