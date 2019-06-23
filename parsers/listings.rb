nokogiri = Nokogiri::HTML(content)

listing = nokogiri.xpath('//div[@id="listing"]//li')

SITE_URL = "https://reviews.birdeye.com"

all_categories = {}

listing.each do |cat|
	title = cat.text.strip
	link = cat.xpath('.//a/@href').text
	url = "#{SITE_URL}#{link}"

	all_categories[title] = url

	pages << {
		url: url,
		page_type: "categories",
		vars: {
			cat_title: title,
			cat_url: url
		}
	}
end

all_categories["_collection"] = "categories_list"