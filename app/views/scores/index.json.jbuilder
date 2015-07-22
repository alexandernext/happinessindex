json.array!(@scores) do |score|
  json.extract! score, :id, :value, :description, :day, :time_of_day, :user_id
  json.url score_url(score, format: :json)
end
