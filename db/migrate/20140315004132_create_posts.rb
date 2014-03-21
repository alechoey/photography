class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :slug, :unique => true
      t.string :title
      t.text :body_before_break
      t.text :body_after_break
      t.timestamps
    end
    
    add_index :posts, :slug
  end
end
