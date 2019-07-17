class HomesController < ApplicationController

	def switchpa
    @mode = switchpa_params[:mode]
    respond_to do|format|
      format.js
    end
	end

	def homegallery
    @user = User.includes(:photos, :albums).find homegallery_params[:param]
    @mode = homegallery_params[:mode]
		home_gallery_id = homegallery_params[:gallery_id].to_i
    if @mode == "albums"
      @home_gallery = @user.albums.includes(:photos).find home_gallery_id
    else @mode == "photos"
      @home_gallery = Photo.find home_gallery_id
    end
    respond_to do|format|
      format.js
    end
	end

	private
	def homegallery_params
    params.require(:data).permit(:param, :mode, :gallery_id)
	end

	def switchpa_params
    params.require(:show).permit(:mode)
  end
end
