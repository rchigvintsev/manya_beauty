class PhotoAlbum < ActiveRecord::Base
  has_many :models, dependent: :destroy

  validates :name, presence: true

  default_scope { order('created_at') }

  def cover_photo
    unless models.empty?
      first_model = models.first
      unless first_model.photos.empty?
        @cover_photo ||= first_model.photos.first
      end
    end
  end
end
