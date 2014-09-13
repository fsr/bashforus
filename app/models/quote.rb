class Quote < ActiveRecord::Base
	include QuotesHelper
	belongs_to :channel
	has_many :likes
	has_many :dislikes
	belongs_to :owner, class_name: 'User'
	def rating
		(self.likes.count+1.0)/(self.dislikes.count+1.0)
	end
	def sources
		quote_sources self
	end
	def tags
		quote_tags self
	end
	def to_html
		output = body
		sources.collect do |source|
			[ "#{source.name}>", "<a class='source' href='/by/#{source.name}'>#{source.name}</a>&gt;"]
		end.map do |search,replace|
			output = output.sub search, replace
		end
		tags.collect do |tag|
			[ "##{tag}", "<a class='tag' href='/tag/#{tag}'>#{tag}</a>"]
		end.map do |search,replace|
			output = output.sub search, replace
		end
		output
	end
end
