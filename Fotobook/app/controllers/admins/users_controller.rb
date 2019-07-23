class Admins::UsersController < AdminsController
	def index
		@users = User.page(params[:page]).order(created_at: :asc)
	end

	def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    temp_params = update_basic_user_params.to_h
    if update_basic_user_params[:password].length == 0
      temp_params.delete(:password)
    end
    if @user.update(temp_params)
      flash[:success] = "Great, Info updated successfully!"
      redirect_to edit_admins_user_path
    else
      flash[:error] = "Update failed :("
      render 'edit'
    end

  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to admins_users_path
  end

	private
  def update_basic_user_params
    params.require(:user).permit(:first_name, :last_name, :email, :active, :password, :avatar)
  end
end
