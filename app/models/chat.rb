class Chat < ApplicationRecord
    has_many :chat_users, dependent: :destroy
    has_many :users, through: :chat_users
    has_many :messages, dependent: :destroy
  
    # enum chat_type: { one_to_one: 0, group: 1 }
end
  