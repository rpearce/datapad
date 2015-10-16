class Scraper
  SELECTORS = {
    category_links: 'a.CategoryTreeLabel',
    article_links: '[class="mw-content-ltr"] a',
    name: '#WikiaPageHeader h1',
    image: '.infoboximage img',
    summary: '#mw-content-text > p'
  }.freeze

  def initialize
    @agent = Mechanize.new { |a| a.user_agent_alias = 'Mac Safari' }
  end

  def scrape_on!
    page = @agent.get('http://starwars.wikia.com/wiki/Category:Individuals_by_faction')
    drill_down(page)
  end

  def drill_down(page)
    category_links = get_links(page: page, selector: SELECTORS[:category_links])
    article_links = get_links(page: page, selector: SELECTORS[:article_links]) if category_links.empty?

    if category_links.empty? && !article_links.empty?
      article_links.each { |link| drill_down(@agent.get(link)) }
    elsif category_links.empty? && article_links.empty?
      create_character(page)
    else
      category_links.each { |link| drill_down(@agent.get(link)) }
    end
  end

  def get_links(page:, selector:)
    page.search(selector).map { |a| a['href'] }
  end

  def get_name(page)
    page.search(SELECTORS[:name]).first.text
  end

  def get_image(page)
    page.search(SELECTORS[:image]).first.try(:[], 'src')
  end

  def get_summary(page)
    page.search(SELECTORS[:summary])[0...2].map { |p| p.text.chomp }.join("\n")
  end

  def create_character(page)
    c = Character.create(
      name: get_name(page),
      image: get_image(page),
      summary: get_summary(page),
      external_uri: page.uri.to_s
    )
    puts c.name if c.persisted?
  end
end
