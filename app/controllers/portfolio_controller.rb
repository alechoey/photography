class PortfolioController < ApplicationController
  include PhotoConcern
  
  def index
    get_photos_by_page
  end
  
  def show
    @photo = Photo.find(params[:id])
    @size = params.permit(:size)[:size]
    @size = @size.downcase.to_sym unless @size.blank?
    @size = :large unless Photo.styles_with_orig.include? @size
  end
end