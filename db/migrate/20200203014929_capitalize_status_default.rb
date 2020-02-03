class CapitalizeStatusDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :pets, :status, 'Adoptable'
  end
end
