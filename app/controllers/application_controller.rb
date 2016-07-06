class ApplicationController < ActionController::Base
  skip_before_filter :verify_authenticity_token

  before_action :check_auth
  after_action :log_response

  include Concerns::ApiResponces

  protected

  def current_api_user
    @current_api_user ||= current_session.try :user
  end

  private

  TOKEN_NAME = :token

  def current_token
    @token ||= params[TOKEN_NAME]
  end

  def current_session
    @session ||= Session.find_by_token(current_token)
  end

  def check_auth
    raise Forbidden if current_api_user.blank?
  end

  def log_response
    puts "RESPONSE [#{response.content_type}]: #{response.body}"
  end
end
