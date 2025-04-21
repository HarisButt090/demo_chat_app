module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end
    private
    def find_verified_user
      # your logic
      instructor_id = request.params["instructorId"]
      puts "📦 Received Token: #{instructor_id}"

      if instructor_id.present?
        
        puts "✅ WebSocket connected at #{Time.now}. This is connection. #{request.params}"
        puts "Instructor ID received: #{instructor_id}"
        User.find(instructor_id)
      else
        reject_unauthorized_connection
        puts "❌ Rejecting connection: No or invalid token"

      end
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      reject_unauthorized_connection # example
      puts "❌ Rejecting connection: No or invalid token"

    end
  end
end
