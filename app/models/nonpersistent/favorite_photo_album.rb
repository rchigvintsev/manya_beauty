class FavoritePhotoAlbum
  def initialize
    @id = 'favorite'
    @name = I18n.translate('photo_album.favorite.name')
    @description = I18n.translate('photo_album.favorite.description')
  end

  attr_reader :id
  attr_reader :name
  attr_reader :description

  def cover_photo
    @cover_photo ||= Photo.where(favorite: true).first
  end

  def models
    models = []
    Photo.where(favorite: true).each { |photo| models << photo.model }
    models.uniq
  end

  def to_s
    @id
  end
end
