class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  scope :friends, -> {where("status = ?", "confirmed")}
  scope :pending_friends, -> {where("status = ?", "pending")}
end
