json.array!(@foods) do |food|
  json.extract! food, :id, :title, :embedded_at, :product_code, :best_before
  json.url food_url(food, format: :json)
end
