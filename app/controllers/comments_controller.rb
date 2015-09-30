class CommentsController < ApplicationController
  before_action :authenticate_user!
  helper_method :date_time_format

  @@date_time_format = '%d %B %Y %H:%M:%S'

  def index
    @comments = Comment.order('created_at DESC').paginate(page: params[:page])
  end

  def date_time_format
    @@date_time_format
  end
end
