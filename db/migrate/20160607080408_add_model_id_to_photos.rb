class AddModelIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :model_id, :integer
  end
end
