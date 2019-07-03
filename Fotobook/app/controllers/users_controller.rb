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
    get_all_photos(@user)

    #passing hash_link of albums to js to use in modal views(next and back)
    gon.hash_links = get_album_hash(@user.albums.includes(:photos))
  end

  def get_all_photos(user)
    @arr = user.photos.order(:created_at)
    @album = []
    @album = user.albums.includes(:photos).all.map{|x| x.photos.map{|y| y}}.flatten
    @arr +=  @album
    @arr = @arr.sort_by{|x| x.created_at}
  end

  def get_albums_count
    @user.albums.count
  end

  def get_album_hash(albums)
    links=[]
    albums.map{|x| links[x.id]=x.photos.map{|y| [y.title,y.description,y.attached_image]}}
    links
  end

  helper_method :get_photos_count
  helper_method :get_albums_count
  helper_method :get_all_photos
  private
  def user_params
    params.require(:user).permit(:email,:first_name,:last_name)
  end


end
