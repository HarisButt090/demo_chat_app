module Queries
  module Messages
    class FetchAllChats < Queries::BaseQuery
        type [Types::Messages::ChatType], null: false
        def resolve(**params)
          Chat.all
        rescue ActiveRecord::RecordNotFound, StandardError => e
          execution_error(message: e.message)
        end
    end
  end
end