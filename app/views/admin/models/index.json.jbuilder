json.array!(@models) do |model|
  json.extract! model, :id, :name, :description, :photo_album_id, :favorite
  json.url admin_model_url(model, format: :json)
end
