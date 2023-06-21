json.extract! user, :id, :name, :dob, :photo, :address, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)
