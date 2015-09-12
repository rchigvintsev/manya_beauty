class Gallery::PhotoAlbumsController < ApplicationController
  def show
    @photo_album = PhotoAlbum.find(params[:id])
  end
end
