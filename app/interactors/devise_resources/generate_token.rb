module DeviseResources
    class GenerateToken < BaseInteractor
      SECRET_KEY = Rails.application.credentials.secret_key_base
  
      delegate :resource, to: :context
      delegate :id, to: :resource, prefix: true
  
      def call
        context.token = generate_token
      end
  
      private
  
        def generate_token
          JWT.encode(payload, SECRET_KEY)
        rescue StandardError => e
          context.fail!(error: e.message)
        end
  
        def expiration_limit
          context.remember_me ? 2.weeks.from_now : 24.hours.from_now
        end
  
        def expiry_time
          @expiry_time ||= expiration_limit
        end
  
        def payload
          {
            sub: resource_id,
            exp: expiry_time.to_i,
            type: resource.type # Adjust this logic for multiple devise models -> resource.is_a?(Customer) ? "customer" : resource.role
          }
        end
    end
  end