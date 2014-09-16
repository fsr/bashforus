require 'source_parser'
require 'tag_parser'
class Quote < ActiveRecord::Base
	include QuotesHelper

	belongs_to :channel
	has_many :likes
	has_many :dislikes
	belongs_to :owner, class_name: 'User'

	after_save :set_related_sources
	after_save :set_related_tags

	acts_as_taggable_on :tags, :sources

	def rating
		(self.likes.count+1.0)/(self.dislikes.count+1.0)
	end

	private
	def set_related_sources
		source_list.add body, parser:SourceParser
	end
	def set_related_tags
		tag_list.add body, parser:TagParser
	end
end
