class Friend < ApplicationRecord
  has_and_belongs_to_many :user, optional: true
  # belongs_to :friend, :class_name => "User"
end
