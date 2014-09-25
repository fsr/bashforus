module UsersHelper
	def owner_by_url user,chan
		channel ||= chan
		Rails.application.routes.url_helpers.owner_by_url(id: user.source_list.first, host: CONFIG['domain'],subdomain: ( @channel || channel).subdomain)
	end
	def found_user_html user,channel
		"<a class='search-result user' href='#{owner_by_url(user,channel)}'>#{user.email}</a>".html_safe unless user.source_list.empty?
	end
end
