class Photo < ActiveRecord::Base
  belongs_to :model

  has_many :comments, -> { order(published_at: :desc) }, dependent: :delete_all

  validates :model_id, :title, :photo_file, presence: true

  mount_uploader :photo_file, PhotoUploader

  default_scope { order('created_at') }
end
