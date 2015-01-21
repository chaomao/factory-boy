class User
	attr_reader :name, :gender
	def initialize(hash)
		@name, @gender = hash[:name], hash[:gender]
	end
end