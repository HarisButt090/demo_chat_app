# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :send_message, mutation: Mutations::Messages::SendMessage
    field :login_user, mutation: Mutations::Users::LoginUser

  end
end
