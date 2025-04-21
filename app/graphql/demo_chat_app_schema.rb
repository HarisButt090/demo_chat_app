# frozen_string_literal: true

class DemoChatAppSchema < GraphQL::Schema
  subscription(Types::SubscriptionType)
  use GraphQL::Subscriptions::ActionCableSubscriptions

  mutation(Types::MutationType)
  query(Types::QueryType)

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader
  
end
