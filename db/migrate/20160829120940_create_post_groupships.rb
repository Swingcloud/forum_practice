class CreatePostGroupships < ActiveRecord::Migration[5.0]
  def change
    create_table :post_groupships do |t|
      t.integer :post_id
      t.integer :group_id

      t.timestamps
    end

    add_index :post_groupships, :post_id
    add_index :post_groupships, :group_id
  end
end
