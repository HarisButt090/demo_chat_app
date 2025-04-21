# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField
    
    field :fetch_all_messages, resolver: Queries::Messages::FetchAllMessages
    field :fetch_all_chats, resolver: Queries::Messages::FetchAllChats
    field :fetch_chat, resolver: Queries::Messages::FetchChat
    field :fetch_user, resolver: Queries::Users::FetchUser


  end
end
