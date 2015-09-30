class Category < ActiveRecord::Base
  has_many :photo_albums, dependent: :nullify

  validates :name, presence: true, uniqueness: true

  default_scope { order('created_at') }
end
