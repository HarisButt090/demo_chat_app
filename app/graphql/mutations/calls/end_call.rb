module Mutations
  module Calls
    class EndCall < BaseMutation
        argument :call_id, ID, required: true
  
        type Types::Calls::CallType
  
        def resolve(call_id:)
          user = context[:current_user]
          raise GraphQL::ExecutionError, "Unauthorized" unless user
  
          call = Call.find_by(id: call_id)
          raise GraphQL::ExecutionError, "Call not found" unless call
          unless [call.caller_id, call.receiver_id].include?(user.id)
            raise GraphQL::ExecutionError, "Not authorized to end this call"
          end
  
          case call.status
          when 'ringing'
            if user.id == call.caller_id
              # Caller cancels during ringing → mark as missed (receiver didn’t pick up)
              call.update!(
                status: :missed,
                ended_at: Time.current,
                duration: 0
              )
            else
              raise GraphQL::ExecutionError, "Receiver cannot end a ringing call"
            end
  
          when 'accepted'
            # Normal call end
            call.update!(
              status: :ended,
              ended_at: Time.current,
              duration: (Time.current - call.started_at).to_i
            )
  
          else
            raise GraphQL::ExecutionError, "Cannot end a call in status #{call.status}"
          end
  
          DemoChatAppSchema.subscriptions.trigger("onCallStatusUpdated", { call_id: call.id }, call)
          call
        end
    end
  end
end
  