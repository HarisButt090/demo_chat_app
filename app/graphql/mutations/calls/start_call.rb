module Mutations
  module Calls
    class StartCall < BaseMutation
        argument :receiver_id, ID, required: true
        argument :call_type, String, required: true
  
        type Types::Calls::CallType
  
        def resolve(receiver_id:, call_type:)
          caller = context[:current_user]
          raise GraphQL::ExecutionError, "Unauthorized" unless caller
  
          receiver = User.find_by(id: receiver_id)
          raise GraphQL::ExecutionError, "Receiver not found" unless receiver
  
          call = Call.create!(
            caller: caller,
            receiver: receiver,
            call_type: call_type,
            status: :ringing
          )

          Calls::MissedCallJob.set(wait: 30.seconds).perform_later(call.id)

          DemoChatAppSchema.subscriptions.trigger("onCallReceived", { user_id: receiver.id }, call)
  
          call
        end
    end
  end
end
  