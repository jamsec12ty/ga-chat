class CreateFriendsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :friends_users do |t|
      t.integer :friend_id
      t.integer :user_id
    end
  end
end
