class CommentsController < ApplicationController
  def create
    photo = Photo.find(params[:photo_id])
    @comment = photo.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to photo_album_path(photo.photo_album),
            notice: 'Comment was successfully created.' }
        format.js
      else
        format.html { redirect_to photo_album_path(photo.photo_album),
            notice: 'Failed to create comment.',
            status: :unprocessable_entity }
        format.js { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:author, :text)
    end
end
