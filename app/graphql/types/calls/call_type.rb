module Types
  module Calls
    class CallType < Types::BaseObject
      field :id, ID, null: false
      field :caller, Types::Users::ObjectType
      field :receiver, Types::Users::ObjectType
      field :call_type, String
      field :status, String
      field :started_at, GraphQL::Types::ISO8601DateTime, null: true
      field :ended_at, GraphQL::Types::ISO8601DateTime, null: true
      field :duration, Integer, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime
    end
  end
end