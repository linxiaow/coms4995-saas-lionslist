class AddUidAndProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :description, :string
  end
end
