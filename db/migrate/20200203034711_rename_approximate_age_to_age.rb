class RenameApproximateAgeToAge < ActiveRecord::Migration[5.1]
  def change
    rename_column :pets, :approximate_age, :age
  end
end
