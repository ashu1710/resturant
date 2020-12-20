class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	
	def after_sign_out_path_for(resource_or_scope)
	    if resource_or_scope == :user
	      new_user_session_path
	    elsif resource_or_scope == :admin
	      new_admin_session_path
	    else
	      root_path
	    end
  	end

  	def after_sign_in_path_for(resource)
  		if resource.class.name == "Admin"
  			admins_dashboard_index_path
  		else
  			root_path
  		end
	end

	protected

	def configure_permitted_parameters
	    added_attrs = [:mobile, :email, :password, :password_confirmation, :remember_me]
	    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(added_attrs) }
	    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(added_attrs) }
	    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(added_attrs) }
	end
end
