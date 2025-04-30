module Types
  class SubscriptionType < Types::BaseObject
    field :message_added, Types::Messages::MessageSubscriptionType, null: true do
      argument :chat_id, ID, required: true
    end

    field :notification_received, Types::Notifications::NotificationSubscriptionType, null: true do
      argument :user_id, ID, required: true
    end
    
    field :message_read, Types::Messages::MessageSubscriptionType, null: true do
      argument :chat_id, ID, required: true
    end

    field :on_call_received, Types::Calls::CallType, null: true do
      argument :user_id, ID, required: true
    end

    field :on_call_status_updated, Types::Calls::CallType, null: true do
      argument :call_id, ID, required: true
    end
    
    def on_call_status_updated(call_id:)
      if object.present? && object.id.to_s == call_id.to_s
        p "Subscription Triggered: Call Status Updated - #{object.status} for Call ID: #{call_id}"
        camelize_keys(object.attributes.symbolize_keys)
      end
    end      

    def on_call_received(user_id:)
      if object.present? && object.receiver_id.to_s == user_id.to_s
        p "Subscription Triggered: Incoming Call for User ID: #{user_id} - Call ID: #{object.id}"
        camelize_keys(object.attributes.symbolize_keys)
      end
    end    

    def message_read(chat_id:)
      if object.present? && object.chat_id.to_s == chat_id.to_s
        p "Subscription Triggered: Message Read for Chat ID: #{chat_id} - Message ID: #{object.id}"
        camelize_keys(object.attributes.symbolize_keys)
      end
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
