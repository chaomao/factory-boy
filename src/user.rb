class User
	attr_reader :name, :gender, :cellphone
	def initialize(hash)
		@name, @gender, @cellphone= hash[:name], hash[:gender], hash[:cellphone]
	end
end