class StaticPagesController < ApplicationController
  def home
  end

  def gallery
    @categories = Category.all
    @photo_albums = PhotoAlbum.all
  end
end
