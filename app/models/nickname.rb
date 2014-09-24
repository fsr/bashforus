class Nickname < String
	def self.strip nickname
		nickname.sub(/^#{CONFIG['nickname_prefix']}/,'')
	end
	def initialize nickname
		@nickname = Nickname.strip nickname
		super @nickname
	end
	def is_claimable?
		User.tagged_with(strip, on: :sources).count == 0
	end
	def is_claimed?
		User.tagged_with(strip, on: :sources).count > 0
	end
	def is_revertable?
		self.is_claimed?
	end
	def is_reverted?
		self.is_claimable?
	end
	def claim_to user
		user.source_list.add strip
		user.save
	end
	def revert
		user = User.tagged_with(strip, on: :sources).first
		user.source_list.remove strip
		user.save
	end
	def user
		User.tagged_with(self.strip, on: :sources).first
	end
	def strip
		Nickname.strip @nickname
	end
	def raw
		'@' + @nickname.strip
	end
end