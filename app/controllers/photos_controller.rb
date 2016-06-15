class PhotosController < ApplicationController
  include PaginationUtils

  before_action :authenticate_user!
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.paginate(page: params[:page])
  end

  def show
  end

  def new
    @photo = Photo.new
  end

  def edit
  end

  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to photos_url(page: last_page(:photo)),
            notice: I18n.translate('photo.flash.actions.create.notice') }
        format.json { render :index, status: :created,
            location: photos_url(page: last_page(:photo)) }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)

        format.html { redirect_to photo_url(@photo, page: current_page),
            notice: I18n.translate('photo.flash.actions.update.notice') }
        format.json { render :show, status: :ok,
            location: photo_url(@photo, page: current_page) }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      page = last_page :photo
      if not page.nil? and page > current_page.to_i
        page = current_page
      end

      format.html { redirect_to photos_url(page: page),
          notice: I18n.translate('photo.flash.actions.destroy.notice') }
      format.json { head :no_content }
    end
  end

  private

    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:title, :description, :photo_file, :model_id, :favorite)
    end
end
