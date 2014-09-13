module QuotesHelper
	def quote_sources quote
		quote.body.scan(/^(\S+)>/).flatten.collect do |source|
			Nickname.find_by name: source
		end.compact
	end
	def quote_tags quote
		quote.body.scan(/#(\S+)/).flatten
	end
end
