class AddRatingToDeals < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :rating, :integer
  end
end
