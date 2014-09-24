class TagParser < ActsAsTaggableOn::GenericParser
  def parse
    ActsAsTaggableOn::TagList.new.tap do |tag_list|
      tag_list.add QuoteSplitter.split(@tag_list).collect{|x| x.scan(Regexp.new("^#{CONFIG['tag_prefix'].strip}.*"))}.flatten.uniq.collect{|tag| Tag.new(tag).strip }
    end
  end
end