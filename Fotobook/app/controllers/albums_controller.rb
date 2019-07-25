class AlbumsController < ApplicationController

  before_action :get_current_album, except: [:create, :new, :index, :remove_img]


  def create_photo_for_album(album,input_params)
    photo_params = input_params.to_h
      if input_params[:attached_image].size == 1
        photo_params[:title] = "Give me a title..."
        photo_params[:description] = "Give me a description..."
        photo_params[:attached_image] = input_params[:attached_image][0]
        @new_photo = album.photos.new(photo_params)
        @new_photo.photoable = album
        @new_photo.save
      else
        Photo.transaction do
          input_params[:attached_image].each do |img_link|
            photo_params[:attached_image] = img_link
            photo_params[:title] = "Give me a title..."
            photo_params[:description] = "Give me a description..."
            @photo = Photo.new(photo_params)
            @photo.photoable = album
            @photo.save
          end
        end
      end
  end

  def create
    temp = album_params.to_h
    temp.delete(:attached_image)
    @album = current_user.albums.new(temp)
    if @album.save
      create_photo_for_album(@album,album_params)
      flash[:success] = "Uploaded"
      redirect_to me_path
    else
      render 'new'
    end
  end

  def get_current_album
    @current_album = Album.find(params[:id])
  end
  def edit
    if @current_album.user_id == current_user.id || @current_user.role == 'admin'
      @current_album
    else
      flash[:error] = "Access denied!"
      redirect_to me_path
    end
  end

  def album_like
    action = likes_params[:action]
    liker = current_user.id
    @album = Album.find params[:gallery_id]
    if action == 'like'
      @album.likes.push(liker)
      respond_to do |format|
        format.js
      end
    else
      @album.likes.delete(liker)
      respond_to do |format|
        format.js
      end
    end
    @album.save
  end

  def update
    temp_params=album_params.to_h
    temp_params.delete(:attached_image)
    if @current_album.update(temp_params)
      if album_params[:attached_image]
        create_photo_for_album(@current_album,album_params)
      end
      flash[:success] = "Updated"
      if current_user.role == 'normal'
        redirect_to me_path
      else
        redirect_to admins_photos_path
      end
    else
      flash[:error] = "Update failed :("
      render 'edit'
    end
  end

  def index
    @user = User.includes(:albums).find params[:user_id]
    # get_all_photos(@user)
    respond_to do|format|
      format.js
    end
  end

  def destroy
    Photo.transaction do
      @current_album.destroy
    end
    flash[:success] = "Album has been deleted successfully!"
    redirect_to me_path
  end

  def remove_img
    img_id = params[:img_id]
    album_id = params[:album_id]

    @album = Album.find album_id
    @album.photos.delete(img_id)
  end

  private
  def album_params
    params.require(:album).permit(:title, :sharing_mode, :description, {attached_image:[]})
  end



  def likes_params
    params.require(:likes).permit(:liker_id, :action)
  end



end
