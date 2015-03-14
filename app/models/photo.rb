class Photo < ActiveRecord::Base
  belongs_to :photo_album

  validates :photo_album_id, :title, presence: true

  mount_uploader :photo_file, PhotoUploader
end
