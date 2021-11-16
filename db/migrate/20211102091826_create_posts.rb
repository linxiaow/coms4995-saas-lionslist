class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.string :author
      t.string :author_id
      t.string :category

      t.timestamps
    end
  end
end
