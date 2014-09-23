class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :body, :sources, :tags
  def sources
  	object.source_list
  end
  def tags
  	object.tag_list
  end
end
