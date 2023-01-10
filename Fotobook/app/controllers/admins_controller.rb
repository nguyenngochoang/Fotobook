class AdminsController < ApplicationController
  before_action :check_role

  def check_role
    if current_user.role == 'normal'
      flash[:warning] = 'Access denied'
      redirect_to root_path
    end
  end

end
