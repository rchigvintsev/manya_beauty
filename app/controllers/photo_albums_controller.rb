class PhotoAlbumsController < ApplicationController
  include PhotoAlbumsHelper

  before_action :authenticate_user!, only: [:index, :new]

  respond_to :html, :js

  def index
    @photo_albums = PhotoAlbum.paginate(page: params[:page])
  end

  def new
    @photo_album = PhotoAlbum.new
  end

  def show
    @photo_album = PhotoAlbum.find(params[:id])
  end
end
