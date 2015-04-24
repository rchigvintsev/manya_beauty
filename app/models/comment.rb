class Comment < ActiveRecord::Base
  belongs_to :photo

  validates :photo_id, :author, :text, presence: true
end
