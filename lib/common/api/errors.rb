module Common::Api
  module Errors
    class Base < RuntimeError
      attr_accessor :payload

      def initialize(payload = {})
        @payload = payload
        super
      end

      def name
        self.class.to_s.demodulize.underscore
      end

      def message
        message = I18n.t('api.errors.' + real_code, default: 'Unknown error')
      end
    end

    class Incomplete < Base
      def real_code; 'Incomplete'; end
    end

    class IncorrectEmailOrPassword < Base
      def real_code; 'IncorrectEmailOrPassword'; end
    end

    class NotFound < Base
      def real_code; 'NotFound'; end
    end

    class Forbidden < Base
      def real_code; 'Forbidden'; end
    end
  end
end
