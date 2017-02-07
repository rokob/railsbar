class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :authenticate

  def authenticate
    authenticate_with_http_basic do |username, password|
      user = User.find_by(username: username)
      if user && user.authenticate(password)
        @current_user ||= user
      end
    end
  end

  def current_user
    @current_user
  end
end
