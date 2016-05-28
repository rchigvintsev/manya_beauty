class DropCategories < ActiveRecord::Migration
  def change
    remove_column :photo_albums, :category_id
    drop_table :categories
  end
end
