class PhotoSet < ActiveRecord::Base
  has_many :photo_set_memberships
  has_many :photos, :through => :photo_set_memberships
  
  validates :name, :presence => true
end