class ApplicationController < ActionController::Base

	before_action :authenticate_user!
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected
	def configure_permitted_parameters
		# Permit the `subscribe_newsletter` parameter along with the other
		# sign up parameters.
		devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :avatar])
		devise_parameter_sanitizer.permit(:sign_in, keys: [:first_name, :last_name, :avatar])
		devise_parameter_sanitizer.permit(:update_account, keys: [:first_name, :last_name, :avatar])

	end

	def get_all_photos(user)
    @arr = user.photos.order(:created_at)
    @album = []
    @album = user.albums_photos
    @arr +=  @album
    @arr = @arr.sort_by{|x| x.created_at}
	end

	def check_followings_status(user_to_check,checker)
    checker.followees.include?user_to_check
  end

	helper_method :get_all_photos, :check_followings_status

	private
	# If your model is called User
	def after_sign_in_path_for(resource)
		session["user_return_to"] || root_path
	end

end
