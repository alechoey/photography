class Admin::PhotosController < Admin::ApplicationController  
  include PhotoConcern
  
  def new
    @photo = Photo.new
  end
  
  def create
    @photo = Photo.new(photo_params)
    respond_to do |format|
      if @photo.save
        format.html {
          render :json => [@photo.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render json: {files: [@photo.to_jq_upload]}, status: :created, location: admin_photo_url(@photo) }
      else
        format.html { render 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @photo = Photo.find(params[:id])
    photo_params = params.permit(:cover_photo, :portfolio_photo)
    cover_photo = photo_params[:cover_photo]
    portfolio_photo = photo_params[:portfolio_photo]
    success = true
    success = success && @photo.update_attribute(:cover_photo, cover_photo) unless cover_photo.blank?
    success = success && @photo.update_attribute(:portfolio_photo, portfolio_photo) unless portfolio_photo.blank?
    if success
      flash[:success] = "Photo was successfully #{cover_photo && portfolio_photo ? 'added to' : 'removed from'} #{@photo.cover_photo_changed? ? 'cover photos' : 'portfolio'}"
    end
    respond_to do |format|
      format.html { redirect_to photos_path }
      format.js # update.js.erb
      format.json { head :no_content }
    end
  end
  
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:success] = 'Photo was successfully deleted.'
    respond_to do |format|
      format.html { redirect_to photos_path }
      format.js {
        get_photos_by_page
        render 'destroy'
      }
      format.json { render json: {files: [@photo.to_jq_delete]} }
    end
  end
  
  private
  
  def photo_params
    params.require(:photo).permit(:photo_list => [])
  end
end