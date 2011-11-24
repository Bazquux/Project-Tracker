class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  validates :name , :presence => true 
	validates :body , :presence => true
  
  has_attached_file :asset
  
end
