class UsersController < ApplicationController


  def index
  end
  def feeds
  end
  def new
    redirect_to new_user_registration_path
  end
  def show
    @user = User.includes(:photos,:albums).find(params[:id])
  end

  def myprofile
    @user = current_user
    @@res||= []
    @@res=get_all_photos(@user)
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
    puts current_gallery_id
    if @mode=="albums"
      @current_gallery = @user.albums.find current_gallery_id
    elsif @mode=="photos"
      @current_gallery = @@res[current_gallery_id-1]
    end
    puts @arr
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



  def get_album_hash(albums)
    links=[]
    albums.map{|x| links[x.id]=x.photos.map{|y| [y.title,y.description,y.attached_image]}}
    @links
  end

  def get_current_album_load(index)
    current_album_load = @user.albums[index]
  end


  helper_method :get_photos_count
  helper_method :get_albums_count
  helper_method :get_all_photos
  helper_method :get_current_album_load

  private
  def user_params
    params.require(:user).permit(:email,:first_name,:last_name)
  end

  def task_params
    params.require(:data).permit(:param,:mode,:gallery_id)
  end


end
