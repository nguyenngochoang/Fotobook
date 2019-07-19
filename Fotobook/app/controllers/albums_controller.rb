class AlbumsController < ApplicationController

  before_action :get_current_album, except: [:create, :new, :index]

  def create
    temp = album_params.to_h
    temp.delete(:attached_image)
    @album = current_user.albums.new(temp)
    if @album.save
      photo_params = album_params.to_h
      if album_params[:attached_image].size == 1
        photo_params[:title] = "Give me a title..."
        photo_params[:description] = "Give me a description..."
        photo_params[:attached_image] = album_params[:attached_image][0]
        @new_photo = @album.photos.new(photo_params)
        @new_photo.photoable = @album
        @new_photo.save
      else
        Photo.transaction do
          album_params[:attached_image].each do |img_link|
            photo_params[:attached_image] = img_link
            photo_params[:title] = "Give me a title..."
            photo_params[:description] = "Give me a description..."
            @photo = Photo.new(photo_params)
            @photo.photoable = @album
            @photo.save
          end
        end
      end
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
   @current_album
  end

  def album_like
    action = likes_params[:action]
    liker = likes_params[:liker_id].to_i
    @album = Album.find params[:id]
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
        photo_params = album_params
        if album_params[:attached_image].size == 1
          photo_params[:attached_image] = album_params[:attached_image][0]
          photo_params[:title] = "Give me a title..."
          photo_params[:description] = "Give me a description..."
          @photo = Photo.new(photo_params)
          @photo.photoable = @current_album
          @photo.save
        else
          Photo.transaction do
            album_params[:attached_image].each do |img_link|
              photo_params[:attached_image] = img_link
              photo_params[:title] = "Give me a title..."
              photo_params[:description] = "Give me a description..."
              @photo = Photo.new(photo_params)
              @photo.photoable = @current_album
              @photo.save
            end
          end
        end
      end
      flash[:success] = "Updated"
      if current_user.role == 'normal'
        redirect_to me_path
      else
        redirect_to manage_photos_path
      end
    else
      flash[:error] = "Update failed :("
      render 'edit'
    end
  end

  def index
    @user = User.includes(:albums).find show_params[:param]
    # get_all_photos(@user)
    respond_to do|format|
      format.js
    end
  end

  def destroy
    @current_album.destroy
    flash[:success] = "Album has been deleted successfully!"
    redirect_to me_path
  end

  def album_params
    params.require(:album).permit(:title, :sharing_mode, :description, {attached_image:[]})
  end

  def show_params
    params.require(:data).permit(:param, :mode, :gallery_id)
  end

  def likes_params
    params.require(:likes).permit(:liker_id, :action)
  end

end
