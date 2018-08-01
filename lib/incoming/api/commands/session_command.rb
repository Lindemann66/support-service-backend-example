module Incoming::Api::Commands
  class SessionCommand < BaseCommand
    def create
      email = params[:email]
      password = params[:password]

      raise_error(:incomplete) if email.blank? or password.blank?

      user = User.find_by_email(email)
      raise_error(:incorrect_email_or_password) if user.blank?

      if user.password != Encryptor.encrypt(password)
        raise_error(:incorrect_email_or_password)
      end
      session_token = user.session.create.token
      response(user: user, token: session_token)
    end

    def destroy_session
      token = params[:token]
      raise_error(:incomplete) if token.blank?

      user_session = Session.find_by_token(token)
      raise_error(:not_found) if user_session.blank?

      user_session.destroy
      response
    end
  end
end
