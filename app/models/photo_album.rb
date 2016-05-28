class PhotoAlbum < ActiveRecord::Base
  has_many :photos, dependent: :destroy

  validates :name, presence: true

  default_scope { order('created_at') }

  def cover_photo
    @cover_photo ||= Photo.where(photo_album_id: id).first
  end
end
