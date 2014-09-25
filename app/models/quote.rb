require 'source_parser'
require 'tag_parser'
class Quote < ActiveRecord::Base
	include QuotesHelper

	belongs_to :channel
	has_many :likes
	has_many :dislikes
	has_many :comments
	belongs_to :owner, class_name: 'User'

	after_save :set_related_sources
	after_save :set_related_tags
	after_save :notify_users

	acts_as_taggable_on :tags, :sources

	scope :visible, ->              { where(visible:true) }
	scope :visible_or_owned_by, -> (owner_id) { where("visible == 't' or owner_id == ?",owner_id )}
	
	searchable do
		text :body
	end

	def rating
		(self.likes.count - self.dislikes.count) + "0.#{created_at.to_i}".to_f
	end

	def to_html
		QuoteSplitter.split(body.sub("\r\n"," <br/> ")).collect do |word|
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
	def to_pushover
		{ 
			title: "You have been quoted by #{owner.email}",
			message: body.truncate(250),
			url: quote_url(self)
		}
	end
	def to_xmpp
		{
			title: "You have been quoted by #{owner.email}",
			message: "#{body}, visit: #{quote_url(self)} for more details"
		}
	end

	def to_found_entry channel
		found_quote_html self, channel
	end
	def is_findable?
	    true
	end
	private
	def set_related_sources
		source_list.uniq.each{|s|source_list.remove(s)}
		source_list.add body, parser:SourceParser
	end
	def set_related_tags
		tag_list.uniq.each{|t|tag_list.remove(t)}
		tag_list.add body, parser:TagParser
	end
	def notify_users
    	User.tagged_with(source_list, on: :sources, any: true).collect{|u|User.find(u.id).notify self}
	end
end
