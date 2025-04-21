module Types
  module Users
    class ObjectType < Types::BaseObject
      include DateTimeHandler

      field :id, ID, null: false
      field :slug, String, null: false
      field :email, String, null: false
      field :first_name, String, null: true
      field :last_name, String, null: true
      field :dob, GraphQL::Types::ISO8601DateTime, null: true
      field :gender, String, null: true
      field :state, String, null: true
      field :phone_no, String, null: true
      field :type, String, null: false
      field :remember_me, Boolean, null: true
      field :terms_and_conditions, Boolean, null: true
      field :permission_role, String, null: true
      field :image_url, String, null: true
      field :deleted, Boolean, null: false
      field :revoke_access, Boolean, null: false
      field :otp_verified, Boolean, null: true
      field :last_otp_verified_at, GraphQL::Types::ISO8601DateTime, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: true
      field :learner_training, Boolean, null: true
      field :international_licence_conversion, Boolean, null: true
      field :postcode, String, null: true
      field :account_status, String, null: true
      field :upcoming_lessons_count, ID, null: true
      field :last_lesson_date, String, null: true
      field :balance, String, null: true
      field :fee_revenue, Float, null: true
      field :service_level, Float, null: true

      # Attributes to support Account Status actions
      field :blocked_actions, GraphQL::Types::JSON, null: true
      field :learner_status, String, null: true
      field :next_availability_date, String, null: true
      

      field :have_payments_to_authorize, Boolean, null: false

      # Attributes to support Members Overview Mock API
      field :full_name, String, null: true
      field :performance_score, Int, null: true
      field :last_sign_in_at, String, null: true
      field :total_lessons, Int, null: true
      field :total_revenue, Float, null: true
      field :alternate_fee_revenue, Float, null: true
      field :fee_rate, Float, null: true
      field :redeemable_gift_cards_presence, Boolean, null: false
      field :amount_earned_from_referees, Integer, null: true
      field :average_review_rate, Float, null: true
      field :total_reviews_count, Int, null: false


      field :google_sync, Boolean, null: true
      field :timezone, String, null: true
      field :timezone_details, GraphQL::Types::JSON, null: true
      
      def image_url
        object.reload
        if object.image.attached?
          Rails.application.routes
            .url_helpers.rails_blob_url(object.image, only_path: true)
        end
      end

      def google_sync
        object.google_account.present?
      end

      def referrer
        object.referrer_log
      end

      def amount_earned_from_referees
        object.referee_logs.paid.sum(:referrer_reward)
      end

      def created_at
        object.created_at
      end

      def dob
        object.dob
      end

      def lessons
        object.lessons.order(lesson_length: :asc)
      end

      def last_lesson_date
        object.last_lesson_date.present? ?
        format_mm_dd_yyyy(object.last_lesson_date) :
        nil
      end

      def balance
        object.balance
      end

      def fee_revenue
        object.fee_revenue if object.is_a? ::Users::Instructor
      end

      def service_level
        object.service_level_hours
      end

      def learner_status
        object.learner_status
      end

      def next_availability_date
        Time.zone.parse(object.next_availability_date) if object.next_availability_date
      rescue NoMethodError => e
        "Wednesday, December 3, 2024 @ 9.30am"
      end

      def upcoming_lessons_count
        object.upcoming_lessons_count
      end

      def last_otp_verified_at
        object.last_otp_verified_at
      end

      def onboarding_steps
        Resolvers::OnboardingStepsResolvers.new(object).onboarding_steps_status
      end

      def service_level_payload
        return unless object.is_a? ::Users::Instructor
        Resolvers::ServiceLevelResolvers.new(object).service_level
      end
      
      def full_name
        object.full_name
      end

      def performance_score
        if object.is_a?(::Users::Instructor)
          ((object.last_thirty_days_hours_worked - object.previous_thirty_days_hours_worked) / (object.previous_thirty_days_hours_worked.zero? ? 1 : object.previous_thirty_days_hours_worked)) * 100
        end
      end

      def last_sign_in_at
        object.last_sign_in_at&.to_i
      end

      def alternate_fee_revenue
        object.fee_revenue if object.is_a?(::Users::Instructor)
      end

      def total_revenue
        object.total_revenue if object.is_a?(::Users::Instructor)        
      end

      def total_lessons
        object.total_lessons
      end

      def fee_rate
        if object.is_a?(::Users::Instructor)
          FeeRateCalculator.new(object.custom_fee, object.service_level).calculate
        end
      end

      def blocked_actions
        actions = {
          "closed" => ['remove_profile_from_search', 'hide_instructor_profile_url', 'no_new_bookings', 'no_bookings_management', 'no_profile_management', 'no_payments_authorization'],
          "suspended" => ['remove_profile_from_search', 'hide_instructor_profile_url', 'no_settings_management', 'no_payments_authorization', 'no_new_bookings', 'no_bookings_management'],
          "onhold" => ['remove_profile_from_search', 'no_new_bookings', 'no_bookings_management'] 
        }

        actions[object.account_status] || []
      end

      def redeemable_gift_cards_presence
        return false if object.is_a?(::Users::SuperAdmin) || object.is_a?(::Users::Admin)

        object.gift_card_users.active.present?
      end

      def average_review_rate
        return unless object.is_a?(::Users::Instructor)

        object.average_review_rate
      end
      
      def total_reviews_count
        object.reviews.visible.count
      end

      def have_payments_to_authorize
        return false if !object.is_a?(::Users::Instructor)

        object.lesson_bookings.authorizable.exists?
      end

      def timezone
        mapping = {
          "Perth" => "WA/Perth",
          "Adelaide" => "SA/Adelaide",
          "Australia/Broken_Hill" => "NSW/Broken Hill",
          "Sydney" => "NSW/Sydney",
          "Darwin" => "NT/Darwin",
          "Brisbane" => "QLD/Brisbane",
          "Canberra" => "ACT/Canberra",
          "Hobart" => "TAS/Hobart",
          "Melbourne" => "VIC/Melbourne"
        }

        mapping[object&.timezone]
      end

      def timezone_details
        return nil unless object.timezone

        mapping = {
          "Perth" => "WA/Perth",
          "Adelaide" => "SA/Adelaide",
          "Australia/Broken_Hill" => "NSW/Broken Hill",
          "Sydney" => "NSW/Sydney",
          "Darwin" => "NT/Darwin",
          "Brisbane" => "QLD/Brisbane",
          "Canberra" => "ACT/Canberra",
          "Hobart" => "TAS/Hobart",
          "Melbourne" => "VIC/Melbourne"
        }
        
        tz_object = ActiveSupport::TimeZone[object.timezone]

        if tz_object
           # Get the current time in that timezone (for the abbreviation and offset)
          now = tz_object.now

          # Get abbreviation and UTC offset
          abbreviation = now.strftime("%Z")  # Timezone abbreviation (e.g., ACST)
          offset = now.formatted_offset       # UTC offset (e.g., +09:30)

          { timezone: mapping[object.timezone], abbreviation: abbreviation, offset: offset }
        end
      end
    end
  end
end