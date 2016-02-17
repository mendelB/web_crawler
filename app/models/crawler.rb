class Crawler
	# browser will hold on to our Mechanize browser object, root will hold our root url,
	# and website will hole the initial website object from memory which is created
	# in the controller with the root url submitted by user
	attr_accessor :browser, :root, :website

	def initialize(website, depth, time_limit)
		@browser = Mechanize.new
		@website = website
		@root = website.url
		# proccess url will be called on the initial root
		proccess_url(website.url)

		# afterwerds, based on the depth requested by the user, the program will attempt to
		# nest into the website by calling the proccess_url on the deepest batch of links.
		# to prevent errors, every time the program loops over this batch, we will increment the
		# attemps var to prevent hitting a depth that doesn't go any deeper, while infinitely attempting to.
		# there is also a timeout function which will time out after user specified time
		attempts = 0
		time = Time.now
		until Website.depth >= depth || attempts > depth || (Time.now - time >= time_limit)
			puts Website.depth
			Website.latest_links.each do |website|
				self.website = website
				proccess_url(website.url)
			end
			attempts += 1
		end
	end

	def proccess_url(url)
		begin
		# we'l fetch the page, call the links and for each link we will
		# run a proccess on the link.
		browser.get(url)
		browser.page.links.each do |link|
			proccess_link(link)
		end
		rescue Exception => e
			puts e
		end
	end

	def proccess_link(link)
		# we'l check out the link to ensure that it hasn't already been proccessed (uniqueness)
		# and that it is a valid link.
		if checks_out?(link)
			# we'l ensure the link isn't external if it is a relative link we'l add the
			# root url to the beginning.
			if !link.uri.host
				url = root + link.href
			elsif link.uri.host == root.gsub(/https?\:\/\/w?w?w?\./, '')
			else
				return 
			end
			url ||= link.href
			# here we'l create a link object in memory which is a child of it's origin link
			# we'l tie it to a webpage object which will create its own website object, that turns
			# our link into a website capable of holding its own links.
			new_link = Link.create(url: url, website_id: website.id)
			webpage = Webpage.create(link_id: new_link.id, title: link.text)
			webpage.create_website
			# we'l log the url to have been proccessed
			Proccessed.create(url: link.href)
		end
	end

	def checks_out?(link)
		link.uri && link.href && not_proccessed?(link.href)
	end

	def not_proccessed?(url)
		!Proccessed.find_by(url: url)
	end

end