class AddPageViewToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :page_views, :integer, :default => 0
  end
end
