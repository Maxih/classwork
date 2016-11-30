json.extract! @pokemon, :id, :name, :attack, :defense, :image_url, :moves, :poke_type, :items

json.items @pokemon.items do |item|
  json.(item, :id, :name, :pokemon_id, :price, :happiness, :image_url)
end
