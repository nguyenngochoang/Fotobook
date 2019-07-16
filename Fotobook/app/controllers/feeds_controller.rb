class FeedsController < ApplicationController

	def index
		@user = User.includes(:photos, :albums).find currentgallery_params[:param]
		@mode = currentgallery_params[:mode]
		current_gallery_id = currentgallery_params[:gallery_id].to_i
		if @mode == "albums"
			@current_gallery = @user.albums.includes(:photos).find current_gallery_id
		else @mode == "photos"
			@current_gallery = Photo.find current_gallery_id
		end
		respond_to do|format|
			format.js
		end
	end

	private
	def currentgallery_params
    params.require(:data).permit(:param, :mode, :gallery_id)
  end

end
