class CommentsController < ApplicationController
  include PaginationUtils

  before_action :authenticate_user!
  before_action :set_comment,
      only: [:show, :edit, :update, :destroy, :publish, :unpublish]

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

  def destroy
    @comment.destroy
    respond_to do |format|
      page = last_page :comment
      if not page.nil? and page > current_page.to_i
        page = current_page
      end

      format.html { redirect_to comments_url(page: page),
          notice: I18n.translate('comment.flash.actions.destroy.notice') }
      format.json { head :no_content }
    end
  end

  def publish
    respond_to do |format|
      if @comment.published
        warning = I18n.translate('comment.flash.actions.publish.warn')

        format.html { redirect_to comments_url(page: current_page),
            flash: { warn: warning }}
        format.json { render json: warning, status: :unprocessable_entity }
      else
        @comment.published = true
        @comment.published_at = DateTime.now

        if @comment.save
          format.html { redirect_to comments_url(page: current_page),
              notice: I18n.translate('comment.flash.actions.publish.notice') }
          format.json { render :index, status: :ok,
              location: comments_url(page: current_page) }
        else
          alert = I18n.translate('comment.flash.actions.publish.alert',
              errors: @comment.errors.full_messages.to_sentence)

          format.html { redirect_to comments_url(page: current_page),
              alert: alert }
          format.json { render json: @comment.errors,
              status: :unprocessable_entity }
        end
      end
    end
  end

  def unpublish
    respond_to do |format|
      if not @comment.published
        warning = I18n.translate('comment.flash.actions.unpublish.warn')

        format.html { redirect_to comments_url(page: current_page),
            flash: { warn: warning }}
        format.json { render json: warning, status: :unprocessable_entity }
      else
        @comment.published = false
        @comment.published_at = nil

        if @comment.save
          format.html { redirect_to comments_url(page: current_page),
              notice: I18n.translate('comment.flash.actions.unpublish.notice') }
          format.json { render :index, status: :ok,
              location: comments_url(page: current_page) }
        else
          alert = I18n.translate('comment.flash.actions.unpublish.alert',
              errors: @comment.errors.full_messages.to_sentence)

          format.html { redirect_to comments_url(page: current_page),
              alert: alert }
          format.json { render json: @comment.errors,
              status: :unprocessable_entity }
        end
      end
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
end
