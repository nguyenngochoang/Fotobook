class FollowsController < ApplicationController

  def create
    @mode = params[:mode]
    @followees_id = params[:followees_id]
    unless current_user.followees.ids.include?@followees_id
      current_user.followees.push User.find @followees_id
    end
  end


  def index
    @user = User.includes(:followees, :followers).find params[:user_id]
    @mode = params[:mode]

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
    @followers_id = params[:followers_id]
    current_user.followees.destroy(User.find @followers_id)
  end


end
