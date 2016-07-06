class Api::SessionsController < ApplicationController
  before_action :check_user_params, only: [:create]
  skip_before_action :check_auth

  def create
    user = User.find_by_email(@email)
    raise IncorrectEmailOrPassword if user.blank?
  
    if user.password != Encryptor.encrypt(@password)
      raise IncorrectEmailOrPassword
    end
    session_token = user.session.create.token
    render json: {user: user, token: session_token, status: 200}
  end

  def destroy_session
    token = params[:token]
    raise Incomplete if token.blank?

    user_session = Session.find_by_token(token)
    raise NotFound if user_session.blank?

    user_session.destroy
    render_success
  end

  private

  def check_user_params
    @email = params[:email]
    @password = params[:password]

    raise Incomplete if @email.blank? or @password.blank?
  end
end
