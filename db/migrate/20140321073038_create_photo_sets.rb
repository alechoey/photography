class CreatePhotoSets < ActiveRecord::Migration
  def change
    create_table :photo_sets do |t|
      t.string :name
      t.timestamps
    end
    
    create_table :photo_set_memberships, :id => false do |t|
      t.integer :photo_id
      t.integer :photo_set_id
      t.timestamps
    end
    
    add_index :photo_set_memberships, :photo_set_id
  end
end
