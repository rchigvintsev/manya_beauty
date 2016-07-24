class FavoritePhotoAlbum
  def initialize
    @id = 'favorite'
    @name = I18n.translate('photo_album.favorite.name')
    @description = I18n.translate('photo_album.favorite.description')
  end

  attr_reader :id
  attr_reader :name
  attr_reader :description

  def has_at_least_one_photo
    models.each do |model|
      unless model.photos.empty?
        return true
      end
    end

    false
  end

  def models
    Model.where(favorite: true)
  end

  def to_s
    @id
  end
end
