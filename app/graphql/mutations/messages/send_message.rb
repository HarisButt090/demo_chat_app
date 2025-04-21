module Mutations
  module Messages
    class SendMessage < BaseMutation
      argument :input, Types::Messages::MessageInput, required: true

      type Types::Messages::MessageType

      def resolve(input:)
        user = context[:current_user]
        raise GraphQL::ExecutionError, "Unauthorized" unless user
      
        message = Message.create!(
          chat_id: input[:chat_id],
          instructor_id: user.id,
          sender_id: user.id,
          content: input[:content],
          message_type: input[:message_type]
        )
      
        DemoChatAppSchema.subscriptions.trigger(
          "message_added",
          { chat_id: input[:chat_id] },
          message
        )
      
        chat = Chat.find(input[:chat_id])
        receiver_ids = chat.users.where.not(id: user.id).pluck(:id)
        
        receiver_ids.each do |receiver_id|
          notification = {
            receiver_id: receiver_id,
            chat_id: input[:chat_id],
            sender_id: user.id,
            message_preview: input[:content].truncate(50),
            created_at: Time.current
          }

          DemoChatAppSchema.subscriptions.trigger(
            "notification_received",
            { user_id: receiver_id },
            notification
          )
        end
      
        message
      end           
    end
  end
end
