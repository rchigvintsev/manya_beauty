class PhotosController < ApplicationController
  before_action :authenticate_user!

  def index
    @photos = Photo.paginate(page: params[:page])
  end
end
