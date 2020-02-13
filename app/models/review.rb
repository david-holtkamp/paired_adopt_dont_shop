class Review < ApplicationRecord
  validates_presence_of :title, :content, :rating
  validates :rating, numericality: {less_than_or_equal_to: 5, greater_than_or_equal_to: 0}
  belongs_to :shelter, dependent: :destroy
end
