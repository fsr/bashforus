module QuotesHelper
	def is_html_tag word
		word =~ /^<([^>]+)>$/
	end
	def is_tag word
		not TagParser.new(word).parse.empty?
	end
	def tag_html word
		tag = Tag.new word
		"<tag><a href='#{tag_url tag}'>#{tag.raw}</a></tag>"
	end
	def is_nickname word
		not SourceParser.new(word).parse.empty?
	end
	def nickname_html word
		nickname = Nickname.new word
		color = ( nickname.user && nickname.user.color ) ? nickname.user.color : Digest::MD5.hexdigest(nickname)[1..6]
		"<nickname style='background-color: ##{color}' onMouseOut=\"this.style.backgroundColor='##{color}'\" onMouseOver=\"this.style.backgroundColor='##{sprintf("%X", color.hex ^ 0xFFFFFF)}'\"><a href='#{by_url nickname}'>#{nickname.raw}</a></nickname>"
	end
	def quote_url quote,chan
		channel ||= chan
		Rails.application.routes.url_helpers.quote_url(id: quote.id, host: CONFIG['domain'],subdomain: ( @channel || channel).subdomain)
	end
	def by_url source
		Rails.application.routes.url_helpers.by_url(id: source, host: CONFIG['domain'],subdomain:  ( @channel || channel).subdomain)
	end
	def tag_url tag
		Rails.application.routes.url_helpers.tag_url(id: tag, host: CONFIG['domain'],subdomain: ( @channel || channel).subdomain)
	end

	def found_quote_html quote, channel
		"<a class='search-result quote' href='#{quote_url(quote,channel)}'>#{quote.body}</a>".html_safe
	end
end
