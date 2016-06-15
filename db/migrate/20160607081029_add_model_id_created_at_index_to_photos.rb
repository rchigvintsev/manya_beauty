class AddModelIdCreatedAtIndexToPhotos < ActiveRecord::Migration
  def change
    add_index :photos, [:model_id, :created_at]
  end
end
