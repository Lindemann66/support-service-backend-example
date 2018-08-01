module Incoming::Api
  class Request
    attr_reader :method, :command, :command_params

    def initialize(method, command, command_params)
      @method = method
      @command = command
      @command_params = command_params
    end

    def process
      klass = klass_for(command)
      results = klass.new(method, command_params).run
      Response.new(results)
    rescue ::Common::Api::Errors::Base => exc
      Response.from_exception(exc)
    end

    private

    def klass_for(command)
      "Incoming::Api::Commands::#{command.to_s.camelcase}Command".constantize
    rescue NameError => exc
      raise exc
    end
  end
end