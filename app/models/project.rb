class Project < ActiveRecord::Base
	
	validates :name , :presence => true , :uniqueness => true
	validates :body , :presence => true
	
	has_many :tickets, :dependent => :destroy
	
	
end
