class Tag < String
	def strip
		self.sub(/^#{CONFIG['tag_prefix']}/,'')
	end
end