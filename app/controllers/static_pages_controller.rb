class StaticPagesController < ApplicationController
  def home
  end

  def gallery
    @categories = Category.all

    category_id = params[:category_id]
    
    @photo_albums = category_id ? PhotoAlbum.where(category_id: category_id) : PhotoAlbum.all
    @photo_albums.each do |photo_album|
      photo_album.cover_photo = Photo.where(photo_album_id: photo_album.id).first
    end
  end
end
