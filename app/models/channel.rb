class Channel < ActiveRecord::Base
  resourcify
  has_many :quotes
  has_and_belongs_to_many :users
  def approve
  	self.update(state:'active')
  end
  def deactivate
  	self.update(state:'inactive')
  end
  def activate
  	self.update(state:'active')
  end
  def active?
  	self.state == 'active'
  end
  def inactive?
  	self.state == 'inactive'
  end
  def approved?
  	self.state == 'active'
  end
  def unapproved?
  	self.state == 'unapproved'
  end
end
