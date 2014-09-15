module ApplicationHelper
	def bash_title
		@channel.present? ? "Quotes from #{@channel.name}" : "Bash For Us Quotes"
	end
end
