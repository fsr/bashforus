class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :body, :sources, :tags, :like_count, :dislike_count, :rating
  def like_count
  	object.likes.count
  end
  def dislike_count
  	object.dislikes.count
  end
  def rating
  	object.rating
  end
  def sources
  	object.source_list
  end
  def tags
  	object.tag_list
  end
end
