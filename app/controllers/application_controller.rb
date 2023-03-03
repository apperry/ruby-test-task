class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

	before_action :authenticate

  attr_reader :current_user

  private

  def authenticate
    authenticate_or_request_with_http_token('Anima') do |token, _opts|
      begin
        payload = JwtHelper.decode(token) and user = User.find_by(id: payload[:id])

        if user
          @current_user = user
          true
        else
          false
        end
      rescue => e
        false
      end
    end
  end
end
