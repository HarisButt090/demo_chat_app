module Mutations
  module Messages
    class MarkMessageAsRead < BaseMutation
        argument :chat_id, ID, required: true
  
        type [Types::Messages::MessageType]
  
        def resolve(chat_id:)
          user = context[:current_user]
          raise GraphQL::ExecutionError, "Unauthorized" unless user
  
          messages = Message.where(chat_id: chat_id, receiver_id: user.id, read_at: nil)
  
          messages.each do |msg|
            msg.update(read_at: Time.current)
            # Trigger subscription using chat_id (works for both group and 1-on-1)
            DemoChatAppSchema.subscriptions.trigger(
              "message_read",
              { chat_id: chat_id },
              msg
            )
          end
  
          messages
        end
    end
  end
end
    