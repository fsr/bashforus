module ApplicationHelper
	def bash_title
		if @channel.present?
			"&laquo;#{@channel.name}&raquo;".html_safe
		else
			"&laquo;&star;&raquo;".html_safe
		end
	end
	def navigation_active_on controller, action=nil
		unless action
			return params[:controller].to_s == controller.to_s && 'active'
		else
			return params[:controller].to_s == controller.to_s && params[:action].to_s == action.to_s && 'active'
		end
	end
end
