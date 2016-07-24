class RemoveFavoriteColumnFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :favorite
  end
end
