class Asset < ActiveRecord::Base	
	belongs_to :ticket
	has_attached_file :asset
	
	
end
