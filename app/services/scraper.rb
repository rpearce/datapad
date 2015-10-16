class Scraper
  def initialize
    @agent = Mechanize.new { |a| a.user_agent_alias = 'Mac Safari' }
  end

  def scrape_on!
    page = @agent.get('http://starwars.wikia.com/wiki/Category:Individuals_by_faction')
    drill_down(page)
  end

  def drill_down(page)
    category_links = get_category_links(page)
    article_links = get_article_links(page) if category_links.empty?

    if category_links.empty? && !article_links.empty?
      article_links.each { |link| drill_down(@agent.get(link)) }
    elsif category_links.empty? && article_links.empty?
      c = Character.create(
        name: get_name(page),
        image: get_image(page),
        summary: get_summary(page),
        external_uri: page.uri.to_s
      )
      puts c.name if c.persisted?
    else
      category_links.each { |link| drill_down(link.click) }
    end
  end

  def get_category_links(page)
    page.links.select { |l| /CategoryTreeLabel/.match(l.dom_class) }
  end

  def get_article_links(page)
    page.search('[class="mw-content-ltr"] a').map { |a| a["href"] }
  end

  def get_name(page)
    page.search('#WikiaPageHeader h1').first.text
  end

  def get_image(page)
    page.search('.infoboximage img').first.try(:[], 'src')
  end

  def get_summary(page)
    page.search('#mw-content-text > p')[0...2].map { |p| p.text.chomp }.join("\n")
  end
end
