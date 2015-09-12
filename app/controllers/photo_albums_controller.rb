class PhotoAlbumsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_photo_album, only: [:show, :edit, :update, :destroy]

  def index
    @photo_albums = PhotoAlbum.paginate(page: params[:page])
  end

  def show
  end

  def new
    @photo_album = PhotoAlbum.new
  end

  def edit
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

  def update
    respond_to do |format|
      if @photo_album.update(photo_album_params)
        format.html { redirect_to @photo_album,
            notice: I18n.translate('photo_album.flash.actions.update.notice') }
        format.json { render :show, status: :ok, location: @photo_album }
      else
        format.html { render :edit }
        format.json { render json: @photo_album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo_album.destroy
    respond_to do |format|
      format.html { redirect_to photo_albums_url,
          notice: I18n.translate('photo_album.flash.actions.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private
    def set_photo_album
      @photo_album = PhotoAlbum.find(params[:id])
    end

    def photo_album_params
      params.require(:photo_album).permit(:name, :description, :category_id)
    end
end
