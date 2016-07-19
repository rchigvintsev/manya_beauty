class Model < ActiveRecord::Base
  belongs_to :photo_album

  has_many :photos, dependent: :destroy

  validates :photo_album_id, :name, presence: true

  def cover_photo
    @cover_photo ||= Photo.where(model_id: id).first
  end
end
