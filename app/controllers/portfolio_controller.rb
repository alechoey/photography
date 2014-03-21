class PortfolioController < ApplicationController
  def index
    @photos = Photo.all
    @photos = @photos.get_portfolio_photos unless user_signed_in?
    @photos = @photos.page(params[:page])
  end
  
  def show
    @photo = Photo.find(params[:id])
    @size = params.permit(:size)[:size]
    @size = @size.downcase.to_sym unless @size.blank?
    @size = :large unless Photo.styles_with_orig.include? @size
  end
end