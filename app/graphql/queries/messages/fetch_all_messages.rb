module Queries
    module Messages
      class FetchAllMessages < Queries::BaseQuery
        argument :chat_id, ID, required: true
        type [Types::Messages::MessageType], null: false
        def resolve(**params)
          Message.where(chat_id: params.dig(:chat_id))
        rescue ActiveRecord::RecordNotFound, StandardError => e
          execution_error(message: e.message)
        end
    end
 end
end