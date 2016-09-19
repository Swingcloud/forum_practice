class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
    	t.integer :user_id, :index => true
    	t.integer :friend_id, :index => true
    	t.string :status, :default => "pending"

      t.timestamps
    end
  end
end
