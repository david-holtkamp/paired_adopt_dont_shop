class ChangeReviewsImageDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :reviews, :image, 'https://images-na.ssl-images-amazon.com/images/I/51-TrKw%2BYtL._AC_SX355_.jpg'
  end
end
