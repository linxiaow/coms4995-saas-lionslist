class AddRatingToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :rating, :integer
  end
end
