class PhotosController < ApplicationController

  before_action :get_current_photo, only: [:edit, :update, :destroy]

  def get_current_photo
    @current_photo = Photo.find(params[:id])
  end


  def index
    @user = User.includes(:photos, :albums).find params[:user_id]
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

  def photo_like
    action = params[:act]
    liker = params[:liker_id].to_i
    if action == 'like'
      @photo = Photo.find params[:id]
      @photo.likes.push(liker)
      @photo.save
      respond_to do |format|
        format.js
      end
    else
      @photo = Photo.find params[:id]
      @photo.likes.delete(liker)
      @photo.save
      respond_to do |format|
        format.js
      end
    end
  end

  def update
    if @current_photo.update(photo_params)
      flash[:success] = "Updated!"
      if current_user.role == 'normal'
        redirect_to me_path
      else
        redirect_to admins_photos_path
      end
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




end