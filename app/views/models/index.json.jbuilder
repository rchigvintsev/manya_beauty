json.array!(@models) do |model|
  json.extract! model, :id, :name, :description, :photo_album_id
  json.url model_url(model, format: :json)
end
