class CreatePets < ActiveRecord::Migration[5.1]
  def change
    create_table :pets do |t|
      t.string :image_path
      t.string :name
      t.string :description
      t.string :approximate_age
      t.string :sex
      t.string :shelter
      t.string :status
      t.timestamps
    end
  end
end
