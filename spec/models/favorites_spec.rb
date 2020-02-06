require 'rails_helper'

RSpec.describe Favorites do
  describe "#total_count" do
    it "can calculate total number of favorites" do
      # favorites = Favorites.new([1, 5, 8, 13, 16])
      favorites = Favorites.new({
        1 => true,
        3 => true,
        4 => true,
        13 => true,
        48 => true
        })
      expect(favorites.total_count).to eq(5)
    end
  end
end
