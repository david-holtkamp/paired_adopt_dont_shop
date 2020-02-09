class AddApprovedToApplicationPets < ActiveRecord::Migration[5.1]
  def change
    add_column :application_pets, :approved, :boolean, default: false
  end
end
