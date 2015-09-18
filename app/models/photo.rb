class Photo < ActiveRecord::Base
  belongs_to :photo_album

  has_many :comments, -> { order(published_at: :desc) }

  validates :photo_album_id, :title, :photo_file, presence: true

  mount_uploader :photo_file, PhotoUploader
end
