module QuotesHelper
	def is_html_tag word
		word =~ /^<([^>]+)>$/
	end
	def is_tag word
		word =~ /^#(\w+)$/
	end
	def tag_html word
		tag = word.scan(/#(\w+)/)[0][0]
		"<tag><a href='/tag/#{tag}'>##{tag}</a></tag>"
	end
	def is_nickname word
		word =~ /^@(\w+)$/ ? true : false
	end
	def nickname_html word
		nickname = word.scan(/@(\w+)/)[0][0]
		"<nickname><a href='/by/#{nickname}'>@#{nickname}</a></nickname>"
	end
end
