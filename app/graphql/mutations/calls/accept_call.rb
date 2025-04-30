module Mutations
  module Calls
    class AcceptCall < BaseMutation
        argument :call_id, ID, required: true
  
        type Types::Calls::CallType
  
        def resolve(call_id:)
          user = context[:current_user]
          raise GraphQL::ExecutionError, "Unauthorized" unless user
  
          call = Call.find_by(id: call_id)
          raise GraphQL::ExecutionError, "Call not found" unless call
          raise GraphQL::ExecutionError, "You are not the receiver of this call" unless call.receiver_id == user.id
  
          call.update!(
            status: :accepted,
            started_at: Time.current
          )
  
          DemoChatAppSchema.subscriptions.trigger("onCallStatusUpdated", { call_id: call.id }, call)
  
          call
        end
    end
  end
end
  