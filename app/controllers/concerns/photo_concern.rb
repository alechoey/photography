module PhotoConcern
  extend ActiveSupport::Concern
  
  def get_photos_by_page
    @photos = Photo.all
    @photos = @photos.get_portfolio_photos unless user_signed_in?
    @photos = @photos.page(params[:page])
  end
end