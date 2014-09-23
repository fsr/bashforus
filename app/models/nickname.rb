class Nickname < String
	def is_claimable?
		User.tagged_with(self, on: :sources).count == 0
	end
	def is_claimed?
		User.tagged_with(self, on: :sources).count > 0
	end
	def is_revertable?
		self.is_claimed?
	end
	def is_reverted?
		self.is_claimable?
	end
	def claim_to user
		user.source_list.add self
		user.save
	end
	def revert
		user = User.tagged_with(self, on: :sources).first
		user.source_list.remove self
		user.save
	end
	def user
		User.tagged_with(self, on: :sources).first
	end
end