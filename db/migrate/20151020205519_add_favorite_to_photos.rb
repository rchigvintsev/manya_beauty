class AddFavoriteToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :favorite, :boolean
  end
end
