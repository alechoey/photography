class Post < ActiveRecord::Base
  validates :slug, :presence => true, :uniqueness => true, :format => {:with => /\A[a-zA-z0-9\-]+\z/}
  validates :title, :presence => true
  
  before_validation :set_slug_from_title, :if => :new_record?
  
  def self.public
    where(:public => true)
  end
  
  def to_param
    slug
  end
  
  private
  
  def set_slug_from_title(auto_slug=nil)
    return if self.slug.present? || self.title.blank?
    auto_slug ||= self.title.downcase.gsub(/[^a-z\s]+/, '').split(/\s+/).reject(&:blank?).join('-')
    posts = Post.where('slug LIKE ?', "#{auto_slug}%")
    if posts.empty?
      self.slug = auto_slug
    else
      nchars = posts.count / 10 + 1
      set_slug_from_title("#{auto_slug[Range.new(0, 255-nchars)]}-#{posts.count+1}")
    end
  end
end
