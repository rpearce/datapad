class Scraper
  START_PAGE = 'http://starwars.wikia.com/wiki/Category:Individuals_by_faction'.freeze
  SELECTORS = {
    category_links: 'a.CategoryTreeLabel',
    article_links: '[class="mw-content-ltr"] a',
    name: '#WikiaPageHeader h1',
    image: '.infoboximage img',
    summary: '#mw-content-text > p'
  }.freeze

  def initialize
    @agent = Mechanize.new { |a| a.user_agent_alias = 'Mac Safari' }
    @affiliations = Affiliation.all
  end

  def scrape_on!
    page = @agent.get(START_PAGE)
    drill_down(page)
  end

  private

  def drill_down(page)
    links = get_links(page, SELECTORS[:category_links])
    links = get_links(page, SELECTORS[:article_links]) if links.empty?

    if links.present?
      links.each { |link| drill_down(@agent.get(link)) }
    else
      create_character(page)
    end
  end

  def get_links(page, selector)
    page.search(selector).map { |a| a['href'] }
  end

  def get_name(page)
    page.search(SELECTORS[:name]).first.text
  end

  def get_image(page)
    src = page.search(SELECTORS[:image]).first.try(:[], 'src')
    /http/.match(src) ? src : nil
  end

  def get_summary(page)
    page.search(SELECTORS[:summary])[0...2].map { |p| p.text.gsub("\n", "") }.join("\n\n")
  end

  def create_character(page)
    infobox = page.search('.infobox').first
    if infobox.present?
      affiliations = affiliation_match?(infobox.text)
      if affiliations.present?
        c = Character.create(
          name: get_name(page),
          image: get_image(page),
          summary: get_summary(page),
          external_uri: page.uri.to_s
        )
        affiliations.each { |a| c.affiliations << a }
        puts c.name if c.persisted?
      end
    end
  end

  def affiliation_match?(text)
    @affiliations.inject([]) do |arr, a|
      arr.push(a) if text.match(/#{a.search_text}/i)
      arr
    end
  end
end
