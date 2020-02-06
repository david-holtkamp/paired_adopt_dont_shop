require 'rails_helper'

RSpec.describe Favorites do
  subject { Favorites.new(
    {'1' => {
      name: "Bud",
      image: "image url"},
    '5' => {
      name: "Spud",
      image: "image url"},
    '8' => {
      name: "Mud",
      image: "image url"},
    '13' => {
      name: "Hud",
      image: "image url"},
    '16' => {
      name: "Dud",
      image: "image url"}
    }) }

  describe "#total_count" do
    it "can calculate total number of favorites" do
      expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_pet" do
    it "adds a pet to its contents" do
      subject.add_pet({id: 3, info: {name:'A', image:'yo'}})
      subject.add_pet({id: 100, info: {name:'B', image:'yo'}})
      subject.add_pet({id: 5, info: {name:'C', image:'yo'}})

      expected_contents =
      {'1' => {
        name: "Bud",
        image: "image url"},
      '5' => {
        name: "Spud",
        image: "image url"},
      '8' => {
        name: "Mud",
        image: "image url"},
      '13' => {
        name: "Hud",
        image: "image url"},
      '16' => {
        name: "Dud",
        image: "image url"},
      '3' => {
        name: "A",
        image: "yo"},
      '100' => {
        name: "B",
        image: "yo"}
      }
      expect(subject.contents).to eq(expected_contents)
    end
  end
end
