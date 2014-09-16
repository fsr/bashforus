module ApplicationHelper
	def bash_title
		@channel.present? ? "Quotes from #{@channel.name}" : "Bash For Us Quotes"
	end
	def navigation_active_on controller
		params[:controller].to_s == controller.to_s && 'active'
	end
end
