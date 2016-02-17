module WelcomeHelper
	def hash_list_tag(website)
	  	html = content_tag(:ul) {
		    ul_contents = ""
		    ul_contents << content_tag(:li, content_tag(:a, website.title, href: website.url))
		    website.links.each do |link|
		      		ul_contents << hash_list_tag(link.webpage.website)
		    end

		    ul_contents.html_safe
	  	}.html_safe
	end

end
