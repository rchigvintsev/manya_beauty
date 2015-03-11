module PhotoAlbumsHelper
  def photo_albums_in_current_category
    category_id = params[:category_id]
    if category_id
      PhotoAlbum.where category_id: category_id
    else
      PhotoAlbum.all
    end
  end
end
