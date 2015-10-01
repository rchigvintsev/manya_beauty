class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show]
  helper_method :date_time_format

  @@date_time_format = '%d %B %Y %H:%M:%S'

  def index
    @comments = Comment.order('created_at DESC').paginate(page: params[:page])
  end

  def show
  end

  def date_time_format
    @@date_time_format
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end
end
