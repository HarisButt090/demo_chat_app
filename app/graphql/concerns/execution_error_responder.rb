module ExecutionErrorResponder
    extend ActiveSupport::Concern
  
    private
  
    def execution_error(message: nil, status: :unprocessable_entity, code: 422)
      GraphQL::ExecutionError.new(message, options: { status: status(code).to_sym, code: code })
    end
  
    def status(code)
      case code
      when 401
        'unauthorized'
      when 403
        'forbidden'
      when 404
        'not_found'
      else
        'unprocessable_entity'
      end
    end
end