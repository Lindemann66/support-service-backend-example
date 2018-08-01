module Incoming::Api::Commands
  class UserCommand < BaseCommand
    attr_reader :current_api_user

    def init_command
      token = params[:token]
      session = Session.find_by_token(token)
      @current_api_user = session.try :user

      raise_error(:forbidden) if @current_api_user.blank?
      raise_error(:forbidden) unless @current_api_user.admin?
    end

    def show
      response(user: current_api_user)
    end

    def managed_users
      response(users: User.where.not(id: current_api_user.id))
    end

    def create
      email = params[:email]
      role = params[:role] || User::CUSTOMER_ROLE_ID
      password = params[:password]

      raise_error(:incomplete) if email.blank? or password.blank?

      User.create(email: email, password: Encryptor.encrypt(password), role: role)
      response
    end

    def destroy_user
      user_id = params[:user_id]
      raise Incomplete if user_id.blank?

      raise Forbidden if user_id == current_api_user.id.to_s

      user = User.find_by_id(user_id)
      raise NotFound if user.blank?
      user.destroy
      response
    end
  end
end
