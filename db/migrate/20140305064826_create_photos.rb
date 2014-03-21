class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :collection_id
      t.boolean :cover_photo
      t.timestamps
    end
    
    add_attachment :photos, :photo
    add_index :photos, :cover_photo
  end
end
