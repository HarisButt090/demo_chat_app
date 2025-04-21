module Queries
  module Users
    class FetchUser < Queries::BaseQuery
  
        argument :id, ID, required: false
  
        type Types::Payloads::UserPayload, null: false
  
        def resolve(**params)
          user = params[:id].present? ? User.friendly.find(params[:id]) : context[:current_user]
          if context[:current_user] || user.is_a?(::Users::Instructor)
            { user: user }
          else
            raise "Unauthorized error"
          end
        rescue ActiveRecord::RecordNotFound, StandardError => e
          execution_error(message: e.message)
        end 
  
    end
  end
end