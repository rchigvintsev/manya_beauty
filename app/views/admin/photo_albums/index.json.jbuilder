json.array!(@photo_albums) do |photo_album|
  json.extract! photo_album, :id, :name, :description
  json.url admin_photo_album_url(photo_album, format: :json)
end
