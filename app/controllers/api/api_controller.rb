class Api::ApiController < ApplicationController
  [:index, :show, :create, :update, :destroy].each do |method_name|
    define_method(method_name) { api_response }
  end

  def api_response
    if params[:action] == 'api_response'
      method = self.request.path_info.split('/').last
    else
      method = params[:id] || params[:action]
    end

    command = params[:command]
    command_params = params.except('controller', 'action', 'command')

    request = Incoming::Api::Request.new(method, command, command_params)
    result = request.process

    logger.info("Response body: #{result.to_s}")
    render json: result
  rescue Common::Api::Errors::NotFound
    logger.info("Unknown method #{method} for command #{command}")
    render status: 404
  end
end
