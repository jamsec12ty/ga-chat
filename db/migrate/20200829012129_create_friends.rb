class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :userA_id
      t.integer :userB_id
      t.text :status

      t.timestamps
    end
  end
end
