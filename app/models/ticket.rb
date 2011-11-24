class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many   :assets
  accepts_nested_attributes_for :assets
  
  validates :name , :presence => true 
	validates :body , :presence => true

  
end
