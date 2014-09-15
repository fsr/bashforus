class Nickname < ActiveRecord::Base
  extend FriendlyId
  belongs_to :user
  has_and_belongs_to_many :quotes
  friendly_id :name, use: :slugged
end
