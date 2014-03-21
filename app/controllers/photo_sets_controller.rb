class PhotoSetsController < ApplicationController
  def index
    @photo_set = PhotoSet.page(params[:page])
  end
  
  def show
    @photo_set = PhotoSet.find(params[:id])
  end
end