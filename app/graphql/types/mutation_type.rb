# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :send_message, mutation: Mutations::Messages::SendMessage
    field :login_user, mutation: Mutations::Users::LoginUser
    field :mark_message_as_read, mutation: Mutations::Messages::MarkMessageAsRead

  end
end
