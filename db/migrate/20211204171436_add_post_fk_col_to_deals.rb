class AddPostFkColToDeals < ActiveRecord::Migration[5.2]
    def change
      add_reference :deals, :post, foreign_key: true
    end
  end