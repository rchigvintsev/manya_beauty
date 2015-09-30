class PhotoAlbum < ActiveRecord::Base
  belongs_to :category

  has_many :photos, dependent: :delete_all

  validates :name, presence: true

  default_scope { order('created_at') }

  attr_accessor :cover_photo
end
