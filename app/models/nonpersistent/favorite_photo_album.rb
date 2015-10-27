class FavoritePhotoAlbum
  def initialize
    @id = 'favorite'
    @name = I18n.translate('photo_album.favorite.name')
    @description = I18n.translate('photo_album.favorite.description')
    @category = nil
  end

  attr_reader :id
  attr_reader :name
  attr_reader :description
  attr_reader :category

  def cover_photo
    @cover_photo ||= Photo.where(favorite: true).first
  end

  def photos
    Photo.where(favorite: true)
  end

  def to_s
    @id
  end
end
