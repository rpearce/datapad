json.characters do
  json.array! @characters do |c|
    json.image c.image
    json.name c.name
    json.homeworld c.homeworld
    json.species c.species
    json.summary c.summary
    json.external_uri c.external_uri
    json.affiliations do
      json.array! c.affiliations.map(&:name)
    end
  end
end
