class StaticPagesController < ApplicationController
  def home
  end

  def gallery
    @categories = Category.all
  end
end
