# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_one_attached :image
  has_many :chat_users
  has_many :chats, through: :chat_users
  
  has_many :outgoing_calls, class_name: 'Call', foreign_key: :caller_id, dependent: :destroy
  has_many :incoming_calls, class_name: 'Call', foreign_key: :receiver_id, dependent: :destroy


end
