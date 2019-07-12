class AlbumsController < ApplicationController


  def edit
    @current_album = Album.find(params[:id])
  end

  def update
    @current_album = Album.find(params[:id])
    temp_params=album_params.to_h
    temp_params.delete(:attached_image)
    if @current_album.update(temp_params)
      if album_params[:attached_image]
        photo_params = album_params
        photo_params[:title] = photo_params.delete(:name)
        photo_params[:title] = "Give me a title..."
        photo_params[:description] = "Give me a description..."
        @photo = Photo.new(photo_params)
        @photo.photoable = @current_album
        @photo.save
      end
      respond_to do |format|
        format.html { redirect_to me_path, flash: { success: "Updated!"}}
      end
    else
      render 'edit'
    end
  end


  def destroy

  end

  def album_params
    params.require(:album).permit(:name,:sharing_mode,:description,:attached_image)
  end

end
