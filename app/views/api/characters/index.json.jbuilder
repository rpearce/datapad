json.characters do
  json.array! @characters, :image, :name, :homeworld, :species, :summary, :external_uri
end

json.categories do
  json.array! @affiliations do |a|
    json.type a.name
    json.display_value a.display_value
  end
end
