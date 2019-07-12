class PhotosController < ApplicationController

  def edit
    @current_photo = Photo.find(params[:id])
  end

  def update
    @current_photo = Photo.find(params[:id])
    if @current_photo.update(photo_params)
      respond_to do |format|
        format.html { redirect_to me_path, flash: { success: "Updated!"}}
      end
    else
      render 'edit_photo'
    end
  end

  def destroy
    @current_photo = Photo.find(params[:id])
    @current_photo.destroy
    respond_to do |format|
      format.html { redirect_to me_path, flash: { success: "Photo has been deleted successfully!"}}
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:title,:description,:sharing_mode,:attached_image)
  end

end
