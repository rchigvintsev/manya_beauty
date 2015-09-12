class Gallery::PhotosController < ApplicationController
  respond_to :html, :js

  def comments
    @photo = Photo.find(params[:id])
  end
end
