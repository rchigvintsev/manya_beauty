class StaticPagesController < ApplicationController
  def home
    @favorite_photos = Photo.where(favorite: true).limit(3)
  end

  def gallery
    @categories = Category.all

    category_id = params[:category_id]
    if category_id
      @photo_albums = PhotoAlbum.where(category_id: category_id)
    else
      all_photo_albums = PhotoAlbum.all
      all_photo_albums.unshift FavoritePhotoAlbum.new
      @photo_albums = all_photo_albums
    end
  end
end
