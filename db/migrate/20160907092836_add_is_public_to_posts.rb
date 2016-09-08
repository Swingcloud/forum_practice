class Add < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :is_public, :boolean, :default => :false
  end
end
