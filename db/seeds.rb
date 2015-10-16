require 'faker'

affiliations = []

10.times do
  a = Affiliation.where(name: Faker::Team.name).first_or_initialize
  if a.new_record?
    a.save!
    affiliations.push(a)
    p 'Affiliation: ' + a.name
  end
end

1000.times do
  c = Character.create!(
    image: Faker::Avatar.image,
    name: Faker::Name.name,
    homeworld: Faker::Team.state,
    species: Faker::Team.name,
    summary: Faker::Lorem.paragraphs.join("\n"),
    external_uri: Faker::Internet.url
  )
  p 'Character: ' + c.name

  rand(1..4).times do
    random_affiliation = affiliations.sample
    c.affiliations << random_affiliation unless c.affiliations.include?(random_affiliation)
  end
end
