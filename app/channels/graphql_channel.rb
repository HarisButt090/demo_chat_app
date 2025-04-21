class GraphqlChannel < ApplicationCable::Channel
  def subscribed
    p 'This is Graphql Channel!!!'
    stream_from params[:channel]
  end

  def unsubscribed
    # Cleanup
  end

  def execute(data)
    p "We are executing GraphQL method Execute! #{data['variables']}, #{data['operationName']}, #{data['query']}"
    query = data["query"]
    variables = ensure_hash(data["variables"])
    operation_name = data["operationName"]
    context = {
      current_user: current_user,
      channel: self
    }

    result = DemoChatAppSchema.execute(
      query: query,
      variables: variables,
      context: context,
      operation_name: operation_name
    )

    payload = {
      result: result.to_h,
      more: result.subscription?
    }

    p '------'
    p data['variables']['messageId']
    p payload
    p result

    transmit(payload)
  end

  private

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? JSON.parse(ambiguous_param) : {}
    when Hash
      ambiguous_param
    when ActionController::Parameters
      ambiguous_param.to_unsafe_h
    else
      {}
    end
  end

  def current_user
    # same token-based auth
  end
end
