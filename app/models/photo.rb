class Photo < ActiveRecord::Base
  belongs_to :photo_album

  validates :photo_album_id, :title, :file_name, presence: true
end
