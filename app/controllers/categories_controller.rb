class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @categories = Category.all
  end

  def new
  end
end
