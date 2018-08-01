module Incoming::Api
  class Response
    attr_reader :command_results

    def self.from_exception(exc)
      results = exc.payload

      results.merge!(status: 500)
      results.merge!(real_code: exc.real_code)
      results.merge!(message: exc.message)
      new(results)
    end

    def initialize(command_results)
      @command_results = command_results.is_a?(Hash) ? command_results : {}
    end

    def to_json(*args)
      command_results.to_json(*args)
    end

    def to_s
      "<#{self.class.name} @command_results=#{command_results.inspect.first(300)}...total #{command_results.inspect.length} bytes>"
    end
  end
end
