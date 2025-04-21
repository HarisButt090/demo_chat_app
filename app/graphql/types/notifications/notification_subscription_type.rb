module Types
  module Notifications
    class NotificationSubscriptionType < Types::BaseObject
        field :chat_id, ID, null: false
        field :sender_id, ID, null: false
        field :message_preview, String, null: false
        field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
end
    