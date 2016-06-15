class Model < ActiveRecord::Base
  belongs_to :photo_album

  has_many :photos, dependent: :destroy

  validates :photo_album_id, :name, presence: true
end
