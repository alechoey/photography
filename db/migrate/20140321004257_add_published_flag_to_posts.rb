class AddPublishedFlagToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :public, :boolean, :default => false
    
    add_index :posts, :public
  end
end
