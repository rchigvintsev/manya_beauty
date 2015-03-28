module PhotoAlbumsHelper
  def photo_albums_in_current_category
    category_id = params[:category_id]
    photo_albums = category_id ? PhotoAlbum.where(category_id: category_id) : PhotoAlbum.all
    photo_albums.each do |photo_album|
      photo_album.cover_photo = Photo.where(photo_album_id: photo_album.id).first
    end
    photo_albums
  end
end
