module Types
  module Messages
    class MessageInput < Types::BaseInputObject
      argument :chat_id, ID, required: true
      argument :instructor_id, ID, required: true
      argument :content, String, required: true
      argument :message_type, String, required: true
    end
  end
end
