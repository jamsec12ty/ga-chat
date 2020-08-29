class Friend < ApplicationRecord
  has_and_belongs_to_many :users, optional: true
  # belongs_to :friend, :class_name => "User"
end
