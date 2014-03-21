class WelcomeController < ApplicationController
  def index
    @photos = Photo.get_cover_photos
    render 'index'
  end
  
  def contact
    render 'contact'
  end
end