namespace :datapad do
  desc 'Add Default Categories'
  task add_affiliations: :environment do
    AFFILIATIONS = [
      { name: 'jedi'     , display_value: 'Jedi'  , search_text: 'jedi order' },
      { name: 'sith'     , display_value: 'Sith'  , search_text: 'sith' },
      { name: 'rebels'   , display_value: 'Rebels', search_text: 'alliance to restore the republic' },
      { name: 'imperials', display_value: 'Empire', search_text: 'galactic empire' },
      { name: 'droids'   , display_value: 'Droids', search_text: 'droid' }
    ].freeze

    AFFILIATIONS.each do |a|
      Affiliation.where(
        name: a[:name],
        display_value: a[:display_value],
        search_text: a[:search_text]
      ).first_or_create
    end
  end
end
