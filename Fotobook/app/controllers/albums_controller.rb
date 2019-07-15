class AlbumsController < ApplicationController

  before_action :get_current_album, only: [:edit, :update, :show]

  def create
    temp = album_params.to_h
    byebug
    temp.delete(:attached_image)
    @album = current_user.albums.new(temp)
    if @album.save
      photo_params = album_params.to_h
      byebug
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
      redirect_to me_path
    else
      flash[:error] = "Update failed :("
      render 'edit'
    end
  end


  def destroy

  end

  def album_params
    params.require(:album).permit(:title, :sharing_mode, :description, {attached_image:[]})
  end

end
