class State < ActiveRecord::Base
	has_many :comments
	has_many :states
	
	def to_s
		name
	end
	
end
