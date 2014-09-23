module QuotesHelper
	def is_html_tag word
		word =~ /^<([^>]+)>$/
	end
	def is_tag word
		word =~ /^#(\w+)/
	end
	def tag_html word
		tag = word.scan(/#([^:, \.]+)/)[0][0]
		word.sub("##{tag}","<tag><a href='#{Rails.application.routes.url_helpers.tag_url(id: tag, host: CONFIG['domain'],subdomain: ( @channel || channel).subdomain)}'>##{tag}</a></tag>")
	end
	def is_nickname word
		word =~ /^@(\w+)/ ? true : false
	end
	def nickname_html word
		nickname = word.scan(/@([^:, \.]+)/)[0][0]
		word.sub("@#{nickname}","<nickname><a href='#{Rails.application.routes.url_helpers.by_url(id: nickname, host: CONFIG['domain'],subdomain:  ( @channel || channel).subdomain)}'>@#{nickname}</a></nickname>")
	end
end
