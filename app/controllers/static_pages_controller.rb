class StaticPagesController < ApplicationController
  def home
    @favorite_photos = Photo.where(favorite: true).limit(4)
  end

  def gallery
    all_photo_albums = PhotoAlbum.all
    all_photo_albums.unshift FavoritePhotoAlbum.new
    @photo_albums = all_photo_albums
  end

  def about
  end
end
