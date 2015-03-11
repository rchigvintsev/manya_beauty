class StaticPagesController < ApplicationController
  include PhotoAlbumsHelper

  def home
  end

  def gallery
    @categories = Category.all
    @photo_albums = photo_albums_in_current_category
  end
end
