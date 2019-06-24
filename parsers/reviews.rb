nokogiri = Nokogiri::HTML content


review = {}

review["business_title"] = nokogiri.xpath('//div[contains(@class, "BusinessBannerInfo__business-title")]/h1/span').text.strip

review_section = nokogiri.xpath('////div[@id="review-section-wrapper"]')


reviews = nokogiri.xpath('//div[@id="review-section-wrapper"]//div[contains(@class, "Review__reviewCardWrapper")]')


all_reviews = []
reviews.each do |rev|
	item = {}
	item["published_date"] = rev.xpath('.//meta[contains(@itemprop, "datePublished")]/@content')
	item["author"] = rev.xpath('.//div[contains(@class, "Review__contentWrapper")]/span').text.strip
	item["source"] = rev.xpath('.//div[contains(@class, "Review__contentWrapper")]/a/@href').text.strip
	item["reviewDate"] =rev.xpath('.//div[contains(@class, "Review__contentWrapper")]/div[contains(@class, "Review__starDateWrapper")]/p[contains(@class, "Review__dateWrapper")]').text.strip
	
	item["text"] = rev.xpath('.//div[contains(@class, "Review__mainReviewWrapper")]//span[contains(@class, "Review__reviewPara")]').text

	item["businessResponse"] = rev.xpath('.//div[contains(@class, "Review__mainReviewWrapper")]//div[contains(@class, "Review__businessResponseWrapper")]//p').text.strip
	
	all_reviews << item
end

review["revs"] = all_reviews
review["_collection"] = "reviews"

outputs << review