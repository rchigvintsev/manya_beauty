class PhotoAlbumsController < ApplicationController
  include PhotoAlbumsHelper

  respond_to :html, :js

  def show
    @photo_album = PhotoAlbum.find(params[:id])
  end
end
