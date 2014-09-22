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

	after_update :set_related_sources
	after_update :set_related_tags

	acts_as_taggable_on :tags, :sources

	def rating
		self.likes.count - self.dislikes.count
	end

	def to_html
		body.sub("\r\n"," <br/> ").split(' ').collect do |word|
			case
			when is_html_tag(word)
				word
			when is_tag(word)
				tag_html word
			when is_nickname(word)
				nickname_html word
			else
				word + " "
			end
		end.join.html_safe
	end

	def is_rateable_by? user_id
		(likes.where(user_id: user_id).count + dislikes.where(user_id: user_id).count) == 0
	end

	def is_visible?
		return false if visible == false
		true
	end
	private
	def set_related_sources
		source_list.add body, parser:SourceParser
	end
	def set_related_tags
		tag_list.add body, parser:TagParser
	end
end
