module Types
  module Payloads
    class UserPayload < Types::BaseObject
      field :token, String, null: true
      field :user, Types::Users::ObjectType, null: true
    end
  end
end