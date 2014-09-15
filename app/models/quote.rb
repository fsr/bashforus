class Quote < ActiveRecord::Base
	include QuotesHelper

	belongs_to :channel
	has_many :likes
	has_many :dislikes
	belongs_to :owner, class_name: 'User'
	has_and_belongs_to_many :sources, class_name: 'Nickname'

	after_save :set_related_sources
	after_save :set_related_tags

	acts_as_taggable

	def rating
		(self.likes.count+1.0)/(self.dislikes.count+1.0)
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
		output.sub("\r\n","<br/>")
	end
	private
	def set_related_sources
		quote_sources(self).each do |source|
			self.sources << source unless self.sources.include? source
		end
	end
	def set_related_tags
		quote_tags(self).each do |tag|
			self.tag_list.add tag
		end
	end
end
