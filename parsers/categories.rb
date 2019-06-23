nokogiri = Nokogiri::HTML(content)

searchlist = nokogiri.xpath('//div[@id="searchlist"]//div[@class="address-bar"]')

PAGE_URL = page['vars']['cat_url']

searchlist.each do |item|
	url = item.xpath('./parent::a/@href').text
	list_title = item.xpath('.//div[@class="business-name"]').text


	pages << {
		url: url,
		page_type: "reviews",
		fetch_type: "browser",
		force_fetch:true,
		vars: {
			cat_title: page['vars']['cat_title'],
			cat_url: page['vars']['cat_url']
		}
	}
end

paginations = nokogiri.xpath('//div[contains(@class, "page-of-pages")]').text.split
start_page = paginations[1].to_i
end_page = paginations[3].to_i

(start_page..end_page).each do |page_num|
	url = "#{PAGE_URL}?page=#{page_num}"

	pages << {
		url: url,
		page_type: "categories",
		vars: {
			cat_title: page['vars']['cat_title'],
			cat_url: page['vars']['cat_url']
		}
	}
end