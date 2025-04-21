module Types
  module Messages
    class MessageType < Types::BaseObject
    field :id, ID, null: false
    field :chat_id, ID, null: true
    field :instructor_id, ID, null: false
    field :content, String, null: false
    field :message_type, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
  