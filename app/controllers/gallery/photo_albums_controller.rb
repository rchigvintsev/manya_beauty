class Gallery::PhotoAlbumsController < ApplicationController
  def show
    id = params[:id]
    if id == 'favorite'
      @photo_album = FavoritePhotoAlbum.new
    else
      @photo_album = PhotoAlbum.find(params[:id])
    end
  end
end
