class User < ActiveRecord::Base
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
  has_many :quotes, foreign_key: :owner_id
  has_many :nicknames
  acts_as_taggable_on :sources
end
