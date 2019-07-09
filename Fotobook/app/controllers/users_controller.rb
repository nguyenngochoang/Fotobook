class UsersController < ApplicationController

  def index
  end
  def feeds
  end

  def show
    @user = User.includes(:photos,:albums,:followers,:followees).find(params[:id])
    get_all_photos(@user)
  end

  def myprofile
    @user = current_user
    get_all_photos(@user)
  end

  def update_basic
    @user = current_user
    @user.avatar = user_basic_params[:avatar]
    @user.first_name = user_basic_params[:first_name]
    @user.last_name = user_basic_params[:last_name]
    if @user.save
      redirect_to edit_profile_path
    else
      render 'edit_profile'
    end
  end

  def task
    @user = User.includes(:photos,:albums).find task_params[:param]
    @mode = task_params[:mode]
    get_all_photos(@user)
    respond_to do|format|
      format.js
    end
  end

  #for performs ajax request and return result to modal
  def currentgallery
    @user = User.includes(:photos,:albums).find task_params[:param]
    @mode = task_params[:mode]
    current_gallery_id = task_params[:gallery_id].to_i
    if @mode=="albums"
      @current_gallery = @user.albums.includes(:photos).find current_gallery_id
    else @mode=="photos"
      @current_gallery = get_all_photos(@user)[current_gallery_id-1]
    end
    respond_to do|format|
      format.js
    end
  end

  def get_all_photos(user)
    @arr = user.photos.order(:created_at)
    @album = []
    @album = user.albums.includes(:photos).all.map{|x| x.photos.map{|y| y}}.flatten
    @arr +=  @album
    @arr = @arr.sort_by{|x| x.created_at}
  end

  def get_albums_count(user)
    user.albums.size
  end

  def get_current_album_load(index)
    current_album_load = @user.albums[index]
  end

  def follow
    @user = User.includes(:followees,:followers).find follow_params[:param]
    @mode = follow_params[:mode]

    if @mode=="followings"
      @followings = @user.followees
    else
      @followers = @user.followers
    end
    respond_to do |format|
      format.js
    end
  end

  def check_followings_status(user_to_check,checker)
    checker.followees.include?user_to_check
  end

  def follow_action
    @user = current_user
    @mode = follow_params[:mode]
    if @mode=="follow"
      @followees_id = follow_params[:followees_id]
      @user.followees.push User.find @followees_id
    else
      @followers_id = follow_params[:followers_id]
      @user.followees.destroy(User.find @followers_id)
    end
  end

  def new_photo

  end

  def edit_profile
    @user = current_user
  end

  helper_method :get_photos_count, :get_albums_count, :get_all_photos, :get_current_album_load,
                :check_followings_status

  private
  def user_basic_params
    params.require(:user).permit(:avatar,:first_name,:last_name)
  end

  def user_params
    params.require(:user).permit(:email,:first_name,:last_name,:avatar)
  end

  def task_params
    params.require(:data).permit(:param,:mode,:gallery_id)
  end

  def follow_params
    params.require(:data).permit(:param,:mode,:followers_id,:followees_id)
  end

end
