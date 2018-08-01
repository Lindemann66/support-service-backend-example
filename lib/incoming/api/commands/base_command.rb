module Incoming::Api::Commands
  class BaseCommand
    attr_reader :method, :params

    def initialize(method, params)
      @method = method
      @params = params.transform_keys(&:to_sym)
    end

    def run
      raise_error(:not_found) unless self.respond_to?(method)
      Rails.logger.info("Perform #{self.class.name} #{method} with #{params.inspect}")

      init_command
      send(method)
    end

    def class_name
      self.class.to_s.demodulize.underscore
    end

    private

    def init_command
    end

    def raise_error(name, payload = {})
      Rails.logger.error "Raising error #{name} with #{payload.inspect}"
      error_class = "::Common::Api::Errors::#{name.to_s.camelcase}".constantize
      if payload.present?
        raise error_class.new(payload)
      else
        raise error_class
      end
    end

    def response(data = {})
      data.merge(status: 200)
    end
  end
end
