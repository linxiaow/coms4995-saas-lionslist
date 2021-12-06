class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      # look at situation to see if we need to use foreign key
      t.string :title
      t.string :status # unsettled, accepted, declined
      t.string :buyer_id
      t.string :buyer_name
      t.string :seller_id
      t.string :seller_name

      t.timestamps
    end
  end
end
