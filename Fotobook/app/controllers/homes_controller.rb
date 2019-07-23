class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:discover, :load_discovers, :switch_photo_album_discover, :homegallery]
  before_action :check_role

  PER_PAGE = 5

  def feeds
    @photos = current_user.followees_photos.page(params[:page]).per(PER_PAGE)
  end

  def load_feeds
    @page = params[:page]
    @mode = params[:mode]
    if @mode == 'photo'
      @photos = current_user.followees_photos.page(params[:page]).per(PER_PAGE)
    elsif @mode == 'album'
      @albums = current_user.followees_albums.page(params[:page]).per(PER_PAGE)
    end
    respond_to do |format|
      format.js
    end
  end

  def discover
    @photos = Photo.all.where(photoable_type: "User").page(params[:page]).per(PER_PAGE)
  end

  def load_discovers
    @page = params[:page]
    @mode = params[:mode]
    if @mode == 'photo'
      @photos = Photo.all.where(photoable_type: "User").order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    elsif @mode == 'album'
      @albums = Album.all.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    end
    respond_to do |format|
      format.js
    end
  end



  def switch_photo_album
    @mode = params[:mode]
    if @mode == 'album'
      @albums = current_user.followees_albums.page(params[:page]).per(PER_PAGE)
    elsif @mode == 'photo'
      @photos = current_user.followees_photos.page(params[:page]).per(PER_PAGE)
    end
    respond_to do|format|
      format.js
    end
  end

  def switch_photo_album_discover
    @mode = params[:mode]
    if @mode == "photo"
      @photos = Photo.all.where(photoable_type: "User").order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    else
      @albums = Album.all.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    end
    respond_to do|format|
      format.js
    end

  end


  def homegallery
    @mode = params[:mode]
    home_gallery_id = params[:gallery_id].to_i
    if @mode == "albums"
      @home_gallery = Album.includes(:photos).find home_gallery_id
    else @mode == "photos"
      @home_gallery = Photo.find home_gallery_id
    end
    respond_to do|format|
      format.js
    end
  end
  private
  def check_role
    if current_user && current_user.role == 'admin'
      redirect_to admins_photos_path
    end
  end


end
