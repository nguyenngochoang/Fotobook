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

  def admin_edit_user
    @user = User.find params[:id]
    puts @user.password
  end

  def update_basic_user
    @user = User.find params[:id]
    temp_params = update_basic_user_params.to_h
    if update_basic_user_params[:password].length == 0
      temp_params.delete(:password)
    end
    if @user.update(temp_params)
      flash[:success] = "Great, Info updated successfully!"
      redirect_to admin_edit_user_path
    else
      flash[:error] = "Update failed :("
      render 'admin_edit_user'
    end

  end

  


  def check_role
    if current_user.role == 'normal'
      flash[:warning] = 'Access denied'
      redirect_to root_path
    end
  end

  private
  def update_basic_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :active, :password, :avatar)
  end


end
