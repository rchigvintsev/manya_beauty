json.array!(@photos) do |photo|
  json.extract! photo, :id, :title, :description, :model_id, :photo_file
  json.url admin_photo_url(photo, format: :json)
end
