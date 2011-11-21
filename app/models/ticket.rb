class Ticket < ActiveRecord::Base
  belongs_to :project
  
  validates :name , :presence => true 
	validates :body , :presence => true
  
  
end
