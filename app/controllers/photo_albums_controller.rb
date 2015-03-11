class PhotoAlbumsController < ApplicationController
  include PhotoAlbumsHelper

  respond_to :html, :js

  def index
    @photo_albums = photo_albums_in_current_category
    respond_with @photo_albums
  end

  def show
    @photos = Photo.where photo_album_id: params[:id]
  end
end
