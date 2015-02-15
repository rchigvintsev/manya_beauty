class PhotoAlbumsController < ApplicationController
  respond_to :html, :js

  def index
    category_id = params[:category_id]
    if category_id
      @photo_albums = PhotoAlbum.where category_id: category_id
    else
      @photo_albums = PhotoAlbum.all
    end
    respond_with @photo_albums
  end
end
