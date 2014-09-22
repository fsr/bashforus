class SourceParser < ActsAsTaggableOn::GenericParser
  def parse
    ActsAsTaggableOn::TagList.new.tap do |tag_list|
      tag_list.add @tag_list.scan(/@([^:, ]+)/).flatten
    end
  end
end