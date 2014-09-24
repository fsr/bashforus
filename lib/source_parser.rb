class SourceParser < ActsAsTaggableOn::GenericParser
  def parse
    ActsAsTaggableOn::TagList.new.tap do |tag_list|
      tag_list.add QuoteSplitter.split(@tag_list).collect{|w|w.scan(Regexp.new("^#{CONFIG['nickname_prefix'].strip}.*"))}.flatten.uniq
    end
  end
end