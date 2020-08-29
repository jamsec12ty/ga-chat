class User < ApplicationRecord
  # Friends
  has_many :friend_sent, class_name: "Friendship", foreign_key: "user_id", inverse_of: "user", dependent: :destroy
  has_many :friend_request, class_name: "Friendship", foreign_key: "friend_id", inverse_of: "friend", dependent: :destroy

  has_many :friends_sent_confirmed, -> {merge(Friendship.friends)}, through: :friend_sent, source: :friend
  has_many :friend_request_confirmed, -> {merge(Friendship.friends)}, through: :friend_request, source: :user
  
  def friends 
    (friends_sent_confirmed.all + friend_request_confirmed.all).uniq
  end

  has_many :pending_requests, -> {merge(Friendship.pending_friends)}, through: :friend_sent, source: :friend

  has_many :received_requests, -> {merge(Friendship.pending_friends)}, through: :friend_request, source: :user

  # Validation
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
