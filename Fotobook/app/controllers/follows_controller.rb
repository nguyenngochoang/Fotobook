class FollowsController < ApplicationController

	def create
    @mode = follow_params[:mode]
		@followees_id = follow_params[:followees_id]
		current_user.followees.push User.find @followees_id
	end


	def index
		@user = User.includes(:followees, :followers).find follow_params[:param]
    @mode = follow_params[:mode]

    if @mode == "followings"
      @followings = @user.followees
    else
      @followers = @user.followers
    end
    respond_to do |format|
      format.js
    end
	end

	def destroy
		@followers_id = follow_params[:followers_id]
		current_user.followees.destroy(User.find @followers_id)
	end


	private
	def follow_params
    params.require(:data).permit(:param, :mode, :followers_id, :followees_id)
  end

end
