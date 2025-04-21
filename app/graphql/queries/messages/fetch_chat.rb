module Queries
 module Messages
    class FetchChat < Queries::BaseQuery
        argument :id, ID, required: true
        type Types::Messages::ChatType, null: false
        def resolve(**params)
          Chat.find(params[:id])
        rescue ActiveRecord::RecordNotFound, StandardError => e
          execution_error(message: e.message)
        end
    end
  end
end