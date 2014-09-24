class QuoteSplitter
  def self.split string
    string.split(Regexp.new(CONFIG['np_word_separators'].strip)).collect do |x|
      x.split(/(?=#{CONFIG['p_word_separators'].strip})/).collect do |y|
        y.split(/(?<=#{CONFIG['p_word_separators'].strip})/).flatten
      end.flatten
    end.flatten
  end
end