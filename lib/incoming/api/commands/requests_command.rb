module Incoming::Api::Commands
  class RequestsCommand < BaseCommand
    attr_reader :current_api_user

    def init_command
      token = params[:token]
      session = Session.find_by_token(token)
      @current_api_user = session.try :user

      raise_error(:forbidden) if @current_api_user.blank?
    end

    def index
      if current_api_user.customer?
        response(requests: current_api_user.requests)
      else
        response(requests: ::Request.all)
      end
    end

    def create
      raise_error(:forbidden) if current_api_user.support?

      request_text = params[:text]
      raise_error(:incomplete) if request_text.blank?

      current_api_user.requests.create(text: request_text)
      response
    end

    def update_request
      raise_error(:forbidden) if current_api_user.customer?

      request_id = params[:id]
      request_status = params[:status]
      raise_error(:incomplete) if request_id.blank? or request_status.blank?

      request = ::Request.find_by_id(request_id)
      raise_error(:not_found) if request.blank?
      
      request.set_status(request_status)
      response
    end

    def destroy_request
      raise_error(:forbidden) unless current_api_user.admin?

      request_id = params[:id]
      raise_error(:incomplete) if request_id.blank?

      request = ::Request.find_by_id(request_id)
      raise_error(:not_found) if request.blank?
      
      request.destroy
      response
    end

    def search
      raise_error(:forbidden) if current_api_user.customer?

      request_text = params[:query].try(:[], :text)
      requests = request_text.present? ? ::Request.by_text(request_text) : Request.all
      response(requests: requests)
    end
  end
end
