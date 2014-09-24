class Tag < String
	def self.strip tag
		tag.sub(/^#{CONFIG['tag_prefix']}/,'')
	end
	def initialize tag
		@tag = Tag.strip tag
		super @tag
	end
	def strip
		@tag.strip
	end
	def raw
		'#' + @tag.strip
	end
end