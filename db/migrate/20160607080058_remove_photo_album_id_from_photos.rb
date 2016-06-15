class RemovePhotoAlbumIdFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :photo_album_id
  end
end
