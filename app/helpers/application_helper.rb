module ApplicationHelper
	
	def admins_only(&block)
		block.call if current_user.try(:admin?)
		nil
	end	
	
	def authorized?(permission, thing, &block)
		block.call if can?(permission.to_sym, thing ) || current_user.try(:admin?)
		nil
	end
	
end
