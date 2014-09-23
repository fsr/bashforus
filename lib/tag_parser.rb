class TagParser < ActsAsTaggableOn::GenericParser
  def parse
    ActsAsTaggableOn::TagList.new.tap do |tag_list|
      tag_list.add @tag_list.scan(Regexp.new(CONFIG['tag_format'].strip)).flatten.uniq
    end
  end
end