json.array!(@comments) do |comment|
  json.extract! comment, :id, :author, :text, :created_at, :published_at, :photo_id
  json.url admin_comment_url(comment, format: :json)
end
