class CreateUserPostships < ActiveRecord::Migration[5.0]
  def change
    create_table :user_postships do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end

    	add_index :user_postships, :post_id
    	add_index :user_postships, :user_id
  end
end
