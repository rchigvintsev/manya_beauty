class PhotoAlbum < ActiveRecord::Base
  belongs_to :category

  has_many :photos

  validates :name, presence: true
end
