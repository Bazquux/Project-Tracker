class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :state
  belongs_to :user
  has_many   :assets  
  accepts_nested_attributes_for :assets
  has_many   :comments
  
  validates :name , :presence => true 
	validates :body , :presence => true

  
end
