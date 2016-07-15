class PhotoAlbum < ActiveRecord::Base
  has_many :models, dependent: :destroy

  validates :name, presence: true

  default_scope { order('created_at') }

  def has_at_least_one_photo
    models.each do |model|
      unless model.photos.empty?
        return true
      end
    end

    false
  end
end
