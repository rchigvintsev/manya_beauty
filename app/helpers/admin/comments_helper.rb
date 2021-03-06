module Admin::CommentsHelper
  @@date_time_format = '%d %B %Y %H:%M:%S'

  def truncate_text(comment)
    comment.text.truncate 75
  end

  def date_time_format
    @@date_time_format
  end

  def draft_comment_count
    Comment.where(published: false).count
  end
end
