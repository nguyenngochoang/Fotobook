class AdminsController < ApplicationController
  before_action :check_role
  def manage_photos
    @photos = Photo.all.page(params[:page]).order(created_at: :desc)
  end

  def manage_albums
    @albums = Album.all.page(params[:page]).order(created_at: :desc)
  end

  def manage_users
    @users = User.all.page(params[:page]).order(created_at: :asc)
  end

  def check_role
    if current_user.role == 'normal'
      flash[:warning] = 'Access denied'
      redirect_to root_path
    end
  end



end
