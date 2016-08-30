class AddLastRepliesAtToPost < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :last_replies, :datetime
  end
end
