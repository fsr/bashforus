module QuotesHelper
	def is_html_tag word
		word =~ /^<([^>]+)>$/
	end
	def is_tag word
		word =~ /^#(\w+)/
	end
	def tag_html word
		tag = word.scan(Regexp.new(CONFIG['tag_format'].strip))[0][0]
		word.sub("##{tag}","<tag><a href='#{tag_url tag}'>##{tag}</a></tag>")
	end
	def is_nickname word
		word =~ /^@(\w+)/ ? true : false
	end
	def nickname_html word
		nickname = Nickname.new word.scan(Regexp.new(CONFIG['nickname_format'].strip))[0][0]
		color = ( nickname.user && nickname.user.color ) ? nickname.user.color : Digest::MD5.hexdigest(nickname)[1..6]
		word.sub("@#{nickname}","<nickname style='background-color: ##{color}'><a href='#{by_url nickname}'>@#{nickname}</a></nickname>")
	end
	def quote_url quote
		Rails.application.routes.url_helpers.quote_url(id: quote.id, host: CONFIG['domain'],subdomain: ( @channel || channel).subdomain)
	end
	def by_url source
		Rails.application.routes.url_helpers.by_url(id: source, host: CONFIG['domain'],subdomain:  ( @channel || channel).subdomain)
	end
	def tag_url tag
		Rails.application.routes.url_helpers.tag_url(id: tag, host: CONFIG['domain'],subdomain: ( @channel || channel).subdomain)
	end
end
