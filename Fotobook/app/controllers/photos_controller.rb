class PhotosController < ApplicationController

  before_action :get_current_photo, only: [:edit, :update, :destroy]

  def get_current_photo
    @current_photo = Photo.find(params[:id])
  end


  def index
    @user = User.includes(:photos, :albums).find show_params[:param]
    respond_to do|format|
      format.js
    end
  end

  def create
    @photo = current_user.photos.new(photo_params)
    if @photo.save
      flash[:success] = "Uploaded!"
      redirect_to me_path
    else
      render 'new'
    end
  end

  def edit
    @current_photo
  end

  def update
    # @current_photo = Photo.find(params[:id])
    if @current_photo.update(photo_params)
      flash[:success] = "Updated!"
      redirect_to me_path
    else
      flash[:error] = "Update failed"
      render 'edit_photo'
    end
  end

  def destroy
    @current_photo.destroy
    flash[:success] = "Photo has been deleted successfully!"
    redirect_to me_path
  end

  private
  def photo_params
    params.require(:photo).permit(:title, :description, :sharing_mode, :attached_image)
  end

  def show_params
    params.require(:data).permit(:param, :gallery_id)
  end

end
