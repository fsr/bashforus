class Like < ActiveRecord::Base
  belongs_to :quote
  belongs_to :user
end
