class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
  has_many :quotes, foreign_key: :owner_id
  has_many :nicknames
  has_many :likes
  has_many :dislikes
  acts_as_taggable_on :sources
  def notify resource
  	Pushover.notification resource.to_pushover.merge(user:pushover_key) unless pushover_key.blank?
  	XmppClient.notification resource.to_xmpp.merge(user:jabber_id) unless jabber_id.blank?
  end
end
