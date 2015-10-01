class CommentsController < ApplicationController
  include PaginationUtils

  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update]
  helper_method :date_time_format

  @@date_time_format = '%d %B %Y %H:%M:%S'

  def index
    @comments = Comment.order('created_at DESC').paginate(page: params[:page])
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)

        format.html { redirect_to comment_url(@comment, page: current_page),
            notice: I18n.translate('comment.flash.actions.update.notice') }
        format.json { render :show, status: :ok,
            location: comment_url(@comment, page: current_page) }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors,
            status: :unprocessable_entity }
      end
    end
  end

  def date_time_format
    @@date_time_format
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
end
