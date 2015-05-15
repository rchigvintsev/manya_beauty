class PhotosController < ApplicationController
  before_action :set_photo, only: [:comments]

  respond_to :html, :js

  def comments
  end

  private

    def set_photo
      @photo = Photo.find(params[:id])
    end
end
