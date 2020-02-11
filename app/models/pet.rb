class Pet < ApplicationRecord
  validates_presence_of :image, :name, :description, :age, :sex, :status
  belongs_to :shelter
  has_many :application_pets, dependent: :destroy
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

  def self.applied_for
    Pet.distinct.joins(:application_pets).order(:id)
  end

  def adopter
    approved_app = application_pets.find_by(approved: true)
    if approved_app
      approved_app.application.name
    end
  end
end
