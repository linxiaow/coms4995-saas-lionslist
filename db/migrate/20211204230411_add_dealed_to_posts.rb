class AddDealedToPosts < ActiveRecord::Migration
  # onshelf 1 is for sale, 0 is offshelf, either deleted or settled
  def change
    add_column :posts, :onshelf, :integer, :default => 1
  end
end
