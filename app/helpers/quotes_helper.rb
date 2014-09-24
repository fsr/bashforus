module QuotesHelper
	def is_html_tag word
		word =~ /^<([^>]+)>$/
	end
	def is_tag word
		logger.debug "Checking if #{word} is tag"
		not TagParser.new(word).parse.empty?
	end
	def tag_html word
		logger.debug "Creating HTML for tag #{word}"
		tag = Tag.new TagParser.new(word).parse.first
		"<tag><a href='#{tag_url tag.strip}'>#{tag}</a></tag>"
	end
	def is_nickname word
		not SourceParser.new(word).parse.empty?
	end
	def nickname_html word
		nickname = Nickname.new SourceParser.new(word).parse.first
		color = ( nickname.user && nickname.user.color ) ? nickname.user.color : Digest::MD5.hexdigest(nickname)[1..6]
		"<nickname style='background-color: ##{color}'><a href='#{by_url nickname.strip}'>#{nickname}</a></nickname>"
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
