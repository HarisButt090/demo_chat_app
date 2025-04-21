module Mutations
  module Users
    class LoginUser < BaseMutation
      argument :login_attributes, Types::Users::LoginAttributes, required: true

      type Types::Payloads::UserPayload

      def resolve(**params)
        result = login_user(params)

        result.success? ? result : execution_error(message: result.error)
      end

      private

        def login_user(params)
          ::DeviseResources::Login.call(
            resource_params: params[:login_attributes].to_h,
            klass: 'User'
          )
        end
    end
  end
end