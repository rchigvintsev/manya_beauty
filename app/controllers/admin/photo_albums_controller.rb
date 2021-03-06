class Admin::PhotoAlbumsController < ApplicationController
  include PaginationUtils

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
        format.html { redirect_to admin_photo_albums_url(page: last_page(:photo_album)),
                                  notice: I18n.translate('photo_album.flash.actions.create.notice') }
        format.json { render :index, status: :created, location: admin_photo_albums_url(page: last_page(:photo_album)) }
      else
        format.html { render :new }
        format.json { render json: @photo_album.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo_album.update(photo_album_params)
        format.html { redirect_to admin_photo_album_url(@photo_album, page: current_page),
                                  notice: I18n.translate('photo_album.flash.actions.update.notice') }
        format.json { render :show, status: :ok, location: admin_photo_album_url(@photo_album, page: current_page) }
      else
        format.html { render :edit }
        format.json { render json: @photo_album.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo_album.destroy
    respond_to do |format|
      page = last_page :photo_album
      if not page.nil? and page > current_page.to_i
        page = current_page
      end

      format.html { redirect_to admin_photo_albums_url(page: page),
                                notice: I18n.translate('photo_album.flash.actions.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private

  def set_photo_album
    @photo_album = PhotoAlbum.find(params[:id])
  end

  def photo_album_params
    params.require(:photo_album).permit(:name, :description)
  end
end
