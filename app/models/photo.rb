class Photo < ActiveRecord::Base
  attr_reader :photo_list
  
  class << self; attr_accessor :styles; end
  @styles = {
    :large => '1200x800',
    :medium => '900x600',
    :small => '600x400',
    :thumb => '300x200'
  }
  def self.styles_with_orig
    @styles.keys.unshift(:original)
  end

  paginates_per 24
  
  has_attached_file(:photo,
    :styles => @styles,
    :storage => :s3,
    :s3_credentials => File.open(Rails.root.join('config', 'paperclip', 's3_credentials.yml')),
    :s3_protocol => 'https',
    :url => ':s3_domain_url',
    :path => ':rails_env/:id/:updated_at/:hash-:filename',
    :hash_secret => ENV['PAPERCLIP_SECRET'] || 'AJSIDKjkjdiSDLfidsjsfs-_12j9293949488f9d00s23jLKLKSDejfoijcndsfpu:Qpqnworgp',
  )
  
  validates_attachment :photo, :presence => true, :content_type => { :content_type => [
    'image/jpg',
    'image/jpeg',
    'image/png',
    'image/gif',
  ]}
  
  def self.get_cover_photos
    where(:cover_photo => true)
  end
  
  def self.get_portfolio_photos
    where(:portfolio_photo => true)
  end
  
  def photo_list=(plist)
    self.photo = plist[0]
  end
  
  include Rails.application.routes.url_helpers
  
  def to_jq_upload
    {
      "name" => read_attribute(:photo_file_name),
      "size" => read_attribute(:photo_file_size),
      "url" => photo.url(:original),
      "thumbnailURL" => photo.url(:thumb),
      "deleteUrl" => admin_photo_path(self),
      "deleteType" => "DELETE"
    }
  end
  
  def to_jq_delete
    { read_attribute(:photo_file_name) => true }
  end
end
