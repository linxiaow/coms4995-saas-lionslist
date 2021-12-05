class AddPostFkColToDeals < ActiveRecord::Migration
    def change
      add_reference :deals, :post, foreign_key: true
    end
  end