class PhotoAlbum < ActiveRecord::Base
  belongs_to :category

  has_many :photos

  validates :name, presence: true

  attr_accessor :cover_photo

  def empty?
    cover_photo.nil?
  end
end
