class UsersController < ApplicationController


  def index
  end
  def feeds
  end

  def show
    @user = User.find(params[:id])
  end

  def myprofile
    @user = User.find(current_user.id)
  end

  def get_photos_count(user)
    @user = User.includes(:albums).find(user.id)
    user_photos = @user.photos.count
    #count user_albums_photos
    @user.albums.all.each{|x| user_photos+= x.photos.count}
    user_photos
  end

  def get_albums_count
    @user.albums.count
  end



  def get_photos_link(user)
    @arr = user.photos.order(:created_at)
    @arr +=  user.albums.all.map{|x| x.photos.map{|y| y}}.flatten
    @arr = @arr.sort_by{|x| x.created_at}
  end

  helper_method :get_photos_count
  helper_method :get_albums_count
  helper_method :get_photos_link

  private
  def user_params
    params.require(:user).permit(:email,:first_name,:last_name)
  end


end
