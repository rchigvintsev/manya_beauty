class Photo < ActiveRecord::Base
  belongs_to :photo_album

  validates :photo_album_id, presence: true
  validates :title, presence: true
  validates :file_name, presence: true
end
