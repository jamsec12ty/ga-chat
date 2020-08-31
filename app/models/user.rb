class User < ApplicationRecord

  # ------------------------ Friends ----------------------- #
  # Define friend requests sent & received
  has_many :request_sent, class_name: "Friendship", foreign_key: "user_id", inverse_of: "user", dependent: :destroy
  has_many :request_received, class_name: "Friendship", foreign_key: "friend_id", inverse_of: "friend", dependent: :destroy

  # Get friends list
  has_many :friends_sent_confirmed, -> {merge(Friendship.friends)}, through: :request_sent, source: :friend
  has_many :friends_request_confirmed, -> {merge(Friendship.friends)}, through: :request_received, source: :user

  def friends
    (friends_sent_confirmed + friends_request_confirmed).uniq.sort_by(&:created_at)
  end

  # Unconfirmed friend requests
  has_many :pending_requests, -> {merge(Friendship.pending_friends)}, through: :request_sent, source: :friend
  has_many :received_requests, -> {merge(Friendship.pending_friends)}, through: :request_received, source: :user

  # ------------------------ Message ----------------------- #
  # Get messages
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", inverse_of: "sender", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id", inverse_of: "recipient", dependent: :destroy

  def all_messages
    (sent_messages + received_messages).sort_by(&:created_at)
  end

  # Get messaged friends
  has_many :sent_messages_friends, -> {merge(User.all)}, through: :sent_messages, source: :recipient
  has_many :received_messages_friends, -> {merge(User.all)}, through: :received_messages, source: :sender

  def all_messaged_friends
    (sent_messages_friends + received_messages_friends).uniq.sort_by(&:created_at)
  end

  # ---------------------- Validations ---------------------- #
  has_secure_password
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :email, presence: true, uniqueness: true
    validates :password, length: { minimum: 6, maximum: 16}, on: :create
end
