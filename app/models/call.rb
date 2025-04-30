class Call < ApplicationRecord
    belongs_to :caller, class_name: 'User'
    belongs_to :receiver, class_name: 'User'
  
    enum call_type: { audio: 0, video: 1 }
    enum status: { ringing: 0, accepted: 1, rejected: 2, ended: 3, missed: 4 }
  
    before_save :calculate_duration, if: -> { ended_at.present? && started_at.present? && duration.blank? }
  
    private
  
    def calculate_duration
      self.duration = (ended_at - started_at).to_i
    end
  end
  