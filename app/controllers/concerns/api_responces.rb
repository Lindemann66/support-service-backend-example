module Concerns::ApiResponces
  extend ActiveSupport::Concern

  class BaseException < Exception; end
  class Forbidden < BaseException; end
  class IncorrectEmailOrPassword < BaseException; end
  class Incomplete < BaseException; end
  class NotFound < BaseException; end
  class FieldValueAlreadyExists < BaseException; end
  class FieldWrongFormat < BaseException; end

  included do
    def self.alias_for(error, *aliases)
      @@alias_names ||= {}
      aliases.each do |cl|
        @@alias_names[cl.to_s] = error.name.demodulize
      end
    end

    def self.get_alias_name(error)
      @@alias_names ||= {}
      @@alias_names[error.class.to_s] || error.class.name.demodulize
    end

    rescue_from BaseException, Forbidden, IncorrectEmailOrPassword, Incomplete,
      NotFound, FieldValueAlreadyExists, ActiveRecord::RecordInvalid, ::ActiveRecord::RecordNotFound,
      ::ActiveModel::StrictValidationFailed, ::ActiveRecord::StatementInvalid, 
      with: :base_exception_handler

    alias_for NotFound, ::ActiveRecord::RecordNotFound
    alias_for FieldValueAlreadyExists, ::ActiveModel::StrictValidationFailed
    alias_for FieldWrongFormat, ::ActiveRecord::RecordInvalid, ::ActiveRecord::StatementInvalid
  end

  protected

  def base_exception_handler(exception)
    Rails.logger.warn("Rescuing from #{exception.class}")
    real_code = ApplicationController.get_alias_name(exception)
    message = I18n.t('api.errors.' + real_code, default: 'Unknown error')
    result_json = { status: 500, real_code: real_code, message: message,
                    fields: (exception.record.errors.keys rescue nil) }

    render json: result_json
  end

  def render_success(json = {})
    render json: json.merge(status: 200)
  end
end
