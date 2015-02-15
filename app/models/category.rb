class Category < ActiveRecord::Base
  has_many :photo_albums

  validates :name, presence: true, uniqueness: true
end
