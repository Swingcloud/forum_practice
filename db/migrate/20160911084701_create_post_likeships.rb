class CreatePostLikeships < ActiveRecord::Migration[5.0]
  def change
		create_table :post_likeships do |t|
    	t.integer :user_id
    	t.integer :post_id
    	t.timestamps
    end

    add_index :post_likeships, :user_id
    add_index :post_likeships, :post_id
  end
end
