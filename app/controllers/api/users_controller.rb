class Api::UsersController < ApplicationController
  before_action :check_permissions, except: [:show]
  skip_before_action :check_auth, :only => [:show]

  def show
    render json: {user: current_api_user}
  end

  def managed_users
    render json: {users: User.where.not(id: current_api_user.id), status: 200}
  end

  def create
    email = params[:email]
    role = params[:role] || User::CUSTOMER_ROLE_ID
    password = params[:password]

    raise Incomplete if email.blank? or password.blank?

    User.create(email: email, password: Encryptor.encrypt(password), role: role)
    render_success
  end

  def destroy_user
    user_id = params[:user_id]
    raise Incomplete if user_id.blank?

    raise Forbidden if user_id == current_api_user.id.to_s

    user = User.find_by_id(user_id)
    raise NotFound if user.blank?
    user.destroy
    render_success
  end

  private

  def check_permissions
    raise Forbidden unless current_api_user.admin?
  end
end
