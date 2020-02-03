class RenamePetImagePathToImage < ActiveRecord::Migration[5.1]
  def change
    rename_column :pets, :image_path, :image 
  end
end
