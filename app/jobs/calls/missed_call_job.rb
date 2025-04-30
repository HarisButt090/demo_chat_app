# frozen_string_literal: true
module Calls
    class MissedCallJob < ApplicationJob
        queue_as :default
    
      def perform(call_id)
        call = Call.find_by(id: call_id)
        return unless call && call.status == "ringing"
    
        call.update!(
            status: :missed,
            ended_at: Time.current,
            duration: 0
        )
    
        DemoChatAppSchema.subscriptions.trigger("onCallStatusUpdated", { call_id: call.id }, call)
      end
    end
  end
  