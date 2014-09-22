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
		return "<button class='btn btn-disabled'>#{fa_icon('thumbs-o-up')} #{quote.likes.count}</button>".html_safe unless current_user
		return "<button class='btn btn-disabled'>#{fa_icon('thumbs-o-up')} #{quote.likes.count}".html_safe unless quote.is_rateable_by? current_user.id
		link_to "#{fa_icon('thumbs-o-up')} #{quote.likes.count}".html_safe,like_quote_path(quote), method: :post, class: 'btn btn-success'
	end
	def dislike_action quote
		return "<button class='btn btn-disabled'>#{fa_icon('thumbs-o-down')} #{quote.dislikes.count}</button>".html_safe unless current_user
		return "<button class='btn btn-disabled'>#{fa_icon('thumbs-o-down')} #{quote.dislikes.count}</button>".html_safe unless quote.is_rateable_by? current_user.id
		link_to "#{fa_icon('thumbs-o-down')} #{quote.dislikes.count}".html_safe, dislike_quote_path(quote), method: :post, class: 'btn btn-danger'
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
