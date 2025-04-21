module Types
  module Messages
    class MessageSubscriptionType < Types::BaseObject
    field :id, ID, null: false
    field :chatId, ID, null: true
    field :instructorId, ID, null: false
    field :content, String, null: false
    field :messageType, String, null: false
    field :createdAt, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
  