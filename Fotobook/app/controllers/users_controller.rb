class UsersController < ApplicationController
  def index
  end
  def feeds
  end
  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:email,:first_name,:last_name)
  end
end
