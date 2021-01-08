json.extract! message, :id, :enabled, :content, :user_id, :created_at, :updated_at
json.url message_url(message, format: :json)
