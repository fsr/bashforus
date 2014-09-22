module QuotesHelper
	def is_html_tag word
		word =~ /^<([^>]+)>$/
	end
	def is_tag word
		word =~ /^#(\w+)$/
	end
	def tag_html word
		tag = word.scan(/#(\w+)/)[0][0]
		"<tag><a href='/tag/#{tag}'><i class='fa fa-tag'></i>#{tag}</a></tag>"
	end
	def is_nickname word
		word =~ /^(\w+)>$/
	end
	def nickname_html word
		nickname = word.scan(/(\w+)>/)[0][0]
		"<nickname><a href='/by/#{nickname}'><i class='fa fa-user'></i>#{nickname}</a></nickname>"
	end
	def like_action quote
		return fa_icon('thumbs-o-up') unless current_user
		return fa_icon('thumbs-o-up') unless quote.is_rateable_by? current_user.id
		link_to fa_icon('thumbs-o-up'),like_quote_path(quote), method: :post
	end
	def dislike_action quote
		return fa_icon('thumbs-o-down') unless current_user
		return fa_icon('thumbs-o-down') unless quote.is_rateable_by? current_user.id
		link_to fa_icon('thumbs-o-down'), dislike_quote_path(quote), method: :post
	end
	def visibility_class quote
		unless quote.is_visible?
			if can? :moderate, quote
				"ghostly"
			else
				"invisible"
			end
		else
			"visible"
		end
	end
end
