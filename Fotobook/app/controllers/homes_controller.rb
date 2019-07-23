class HomesController < ApplicationController

  before_action :check_role

  include ActionView::Helpers::UrlHelper

  def check_role
    if current_user.role == 'admin'
      redirect_to admins_photos_path
    end
  end

  def switch_photo_album
    @mode = params[:mode]
    respond_to do|format|
      format.js
    end
  end

  def switch_photo_album_discover
    @mode = params[:mode]
    if @mode == "photo"
      @photos = Photo.all.where(photoable_type: "User").order(created_at: :desc)
    else
      @albums = Album.all.order(created_at: :desc)
    end
    respond_to do|format|
      format.js
    end

  end


  def homegallery
    @user = User.includes(:photos, :albums).find params[:id]
    @mode = params[:mode]
		home_gallery_id = params[:gallery_id].to_i
    if @mode == "albums"
      @home_gallery = @user.albums.includes(:photos).find home_gallery_id
    else @mode == "photos"
      @home_gallery = Photo.find home_gallery_id
    end
    respond_to do|format|
      format.js
    end
  end

  def discover
    @photos = Photo.all.where(photoable_type: "User")
  end



end
