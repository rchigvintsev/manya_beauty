class PhotoAlbumsController < ApplicationController
  include PhotoAlbumsHelper

  before_action :authenticate_user!, only: [:index, :new]

  respond_to :html, :js

  def index
    @photo_albums = PhotoAlbum.paginate(page: params[:page])
  end

  def show
    @photo_album = PhotoAlbum.find(params[:id])
  end

  def new
    @photo_album = PhotoAlbum.new
    @categories = Category.all
  end

  def create
    @photo_album = PhotoAlbum.new(photo_album_params)

    respond_to do |format|
      if @photo_album.save
        format.html { redirect_to photo_albums_url,
            notice: I18n.translate('photo_album.flash.actions.create.notice') }
        format.json { render :index, status: :created, location: photo_albums_url }
      else
        format.html { render :new }
        format.json { render json: @photo_album.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def photo_album_params
      params.require(:photo_album).permit(:name, :description, :category_id)
    end
end
