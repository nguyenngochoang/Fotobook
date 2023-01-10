class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :get_noti, if: :user_signed_in?

  protected
  def configure_permitted_parameters
    # Permit the `subscribe_newsletter` parameter along with the other
    # sign up parameters.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:first_name, :last_name, :avatar])
    devise_parameter_sanitizer.permit(:update_account, keys: [:first_name, :last_name, :avatar])

  end

  def get_all_photos(user)
    arr = (user.photos + user.albums_photos).sort_by(&:created_at)
    @photos = Kaminari.paginate_array(arr).page(params[:page]).per(40)
  end

  def check_followings_status(user_to_check, checker)
    checker.followees.include?user_to_check
  end

  def generate_letter(user)
    (user.first_name[0]+user.last_name[0]).upcase
  end


  def get_noti
    @notifications = Notification.where('user_id = ?', current_user.id)
  end



  helper_method :get_all_photos, :check_followings_status, :generate_letter

  private
  # If your model is called User
  def after_sign_in_path_for(resource)
    current_user.role == 'normal'? root_path : admins_photos_path
  end

end
