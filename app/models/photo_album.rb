class PhotoAlbum < ActiveRecord::Base
  belongs_to :category

  has_many :photos, dependent: :destroy

  validates :name, presence: true

  default_scope { order('created_at') }

  attr_accessor :cover_photo
end
