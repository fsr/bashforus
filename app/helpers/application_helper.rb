module ApplicationHelper
	def bash_title
		if @channel.present?
			"&laquo;#{@channel.name}&raquo;".html_safe
		else
			"&laquo;&star;&raquo;".html_safe
		end
	end
	def navigation_active_on controller
		params[:controller].to_s == controller.to_s && 'active'
	end
end
