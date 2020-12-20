class Api::V1::ApiController < ApplicationController
	include UsersHelper
  before_action :check_authenticate_user

  # Check Authenticate User or not using token
  def check_authenticate_user
    if request.headers[:token].present?
      @auth_token = AuthToken.find_by(token: request.headers[:token])
      @current_user = auth_token.user if @auth_token.present?
      unless @auth_token && @current_user
        error_response_with_obj(HTTP_UNAUTHORIZED[:code], "Invalid Authentication token")
      end
    else
      error_response_with_obj(HTTP_UNAUTHORIZED[:code], "Invalid Authentication token")
    end
  end

  # Return Current User find by check authenticate user
  def current_user
    @current_user
  end

  def auth_token
    @auth_token
  end
end
