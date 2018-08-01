class Api::RequestsController < ApplicationController
  def index
    if current_api_user.customer?
      render json: {requests: current_api_user.requests, status: 200}
    else
      render json: {requests: Request.all, status: 200}
    end
  end

  def create
    raise Forbidden if current_api_user.support?

    request_text = params[:text]
    raise Incomplete if request_text.blank?

    current_api_user.requests.create(text: request_text)
    render_success
  end

  def update_request
    raise Forbidden if current_api_user.customer?

    request_id = params[:id]
    request_status = params[:status]
    raise Incomplete if request_id.blank? or request_status.blank?

    request = Request.find_by_id(request_id)
    raise NotFound if request.blank?
    
    request.set_status(request_status)
    render_success
  end

  def destroy_request
    raise Forbidden unless current_api_user.admin?

    request_id = params[:id]
    raise Incomplete if request_id.blank?

    request = Request.find_by_id(request_id)
    raise NotFound if request.blank?
    
    request.destroy
    render_success
  end

  def search
    raise Forbidden if current_api_user.customer?

    request_text = params[:query].try(:[], :text)
    requests = request_text.present? ? Request.by_text(request_text) : Request.all
    render json: {requests: requests, status: 200}
  end

  def as_pdf
    raise Forbidden if current_api_user.customer?

    request_id = params[:id]
    raise Incomplete if request_id.blank?

    request = Request.find_by_id(request_id)
    raise NotFound if request.blank?

    send_data request.as_pdf, type: 'application/pdf', filename: Request::PDF_FILENAME, 
      disposition: :attachment
  end
end
