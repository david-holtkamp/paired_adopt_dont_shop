require 'rails_helper'

RSpec.describe Favorites do
  subject { Favorites.new(["1", "5", "8", "13", "16"]) }

  describe "#total_count" do
    it "can calculate total number of favorites" do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_pet" do
    it "adds a pet to its contents" do
      subject.add_pet(3)
      subject.add_pet(100)
      subject.add_pet(5)

      expect(subject.contents).to eq(["1", "5", "8", "13", "16", "3", "100"])
    end
  end

  describe "#delete_pet" do
    it "deletes a pet from its contents" do
      subject.delete_pet(13)

      expect(subject.contents).to eq(["1", "5", "8", "16"])
    end
  end

  describe "#delete_pets" do
    it "deletes many pets from its contents" do
      subject.delete_pets([13, 1, 16])

      expect(subject.contents).to eq(["5", "8"])
    end
  end

  describe "#reset" do
    it "resets its contents" do
      subject.reset

      expect(subject.contents).to eq([])
    end
  end
end
