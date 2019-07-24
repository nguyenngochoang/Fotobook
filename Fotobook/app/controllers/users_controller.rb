class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    get_all_photos(@user)
  end

  def myprofile
    @user = current_user
    get_all_photos(@user)
  end

  def edit
    redirect_to edit_user_path
  end

  def update_basic
    @user = current_user
    if @user.update(user_basic_params)
      flash[:success] = "Great, Info updated successfully!"
      redirect_to edit_profile_path
    else
      flash[:error] = "Update failed :("
      render 'edit_profile'
    end
  end

  def update_password
    @user = current_user
    if @user.valid_password?(params[:user][:current_password])
      if @user.update(user_password_params)
        flash[:success] = "Password updated successfully"
        redirect_to edit_profile_path
      else
        flash[:error] = "Updated failed :("
        render 'edit_profile'
      end
    else
      flash[:error] = "Wrong current password"
      redirect_to edit_profile_path
    end
  end

  #for performs ajax request and return result to modal
  def currentgallery
    current_gallery_id = params[:gallery_id].to_i
    @mode = params[:mode]
    if @mode == "albums"
      @current_gallery = Album.includes(:photos).find current_gallery_id
    else @mode == "photos"
      @current_gallery = Photo.find current_gallery_id
    end
    respond_to do|format|
      format.js
    end
  end

  def edit_profile
    @user = current_user
  end


  private
  def user_password_params
    params.require(:user).permit(:password)
  end

  def file_extension_params
    params.require(:valid).permit(:state)
  end

  def user_basic_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :email)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :avatar)
  end

  def follow_params
    params.require(:data).permit(:param, :mode, :followers_id, :followees_id)
  end
end
