module DeviseResources
  class Login < BaseInteractor
    def call
      @resource = User.find_by('LOWER(email) = ?', context.resource_params[:email].downcase)

      unless @resource&.valid_password?(context.resource_params[:password])
        context.fail!(error: 'Invalid credentials')
        return
      end

      token_result = DeviseResources::GenerateToken.call(resource: @resource)

      context.user = @resource
      context.token = token_result.token
    rescue => e
      context.fail!(error: e.message)
    end
  end
end
