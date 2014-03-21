class Admin::PhotoSetsController < Admin::ApplicationController
  def new
    @photo_set = PhotoSet.new
  end
  
  def create
    @photo_set = PhotoSet.new(photo_set_params)
    respond_to do |format|
      if @photo_set.save
        flash[:success] = 'Photo set successfully created'
        format.html { redirect_to photo_sets_path }
      else
        @errors = @photo_set.errors.full_messages
        format.html { render 'new' }
      end
    end
  end
  
  def edit
    @photo_set = PhotoSet.find(params[:id])
  end
  
  def update
    @photo_set = PhotoSet.find(params[:id])
    respond_to do |format|
      if @photo_set.update_attributes(photo_set_params)
        flash[:success] = 'Photo set sucessfully updated'
        format.html { redirect_to photo_set_path(@photo_set) }
      else
        @errors = @photo_set.errors.full_messages
        format.html { render 'edit' }
      end
    end
  end
  
  def destroy
    @photo_set = PhotoSet.find(params[:id])
    respond_to do |format|
      if @photo_set.destroy
        flash[:success] = 'Photo set successfully deleted'
        format.html { redirect_to photo_sets_path }
      else
        format.html { render 'photo_sets/show' }
      end
    end
  end
  
  private
  
  def photo_set_params
    params.require(:name)
  end
end