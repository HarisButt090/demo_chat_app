module Types
  class SubscriptionType < Types::BaseObject
    field :message_added, Types::Messages::MessageSubscriptionType, null: true do
      argument :chat_id, ID, required: true
    end

    field :notification_received, Types::Notifications::NotificationSubscriptionType, null: true do
      argument :user_id, ID, required: true
    end
    
    def notification_received(user_id:)
      p "Hello from subscription Method Notification Received - User ID: #{user_id}, Object: #{object.inspect}"
      camelize_keys(object.symbolize_keys) if object.present? && object[:receiver_id].to_s == user_id.to_s
    end
    
    def message_added(chat_id:)
      p "Hello from subscription Method Message Added #{chat_id} #{object.inspect}"
      # triggered automatically, just return object
      camelize_keys(object.attributes.symbolize_keys) if object.present?
      
      # p object.inspect#Chat.find(chat_id)
    end

    def camelize_keys(hash)
      hash.transform_keys { |key| key.to_s.camelize(:lower).to_sym }
    end
  end
end
