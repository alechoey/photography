class AddPortfolioPhotoToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :portfolio_photo, :boolean, :default => false
    
    add_index :photos, :portfolio_photo
  end
end
