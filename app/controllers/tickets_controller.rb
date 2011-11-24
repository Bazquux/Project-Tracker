class TicketsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_project
	before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]
	before_filter :authorize_create!, :only => [:new, :create]
	before_filter :authorize_update!, :only => [:edit, :update]
	before_filter :authorize_delete!, :only => [:destroy]
		
	def show		
	end
	
	def new
		@ticket = @project.tickets.build
	end
	
	def edit		
	end
	
	def create
		@ticket = @project.tickets.build(params[:ticket].merge!(:user => current_user))
		if @ticket.save
			flash[:notice] = "Ticket has been created"
			redirect_to [@project, @ticket]
		else
			flash[:alert] = "Ticket has not been created"
			render 'new'
		end
	end
	
	def update
		if @ticket.update_attributes(params[:ticket])
			flash[:notice] = "Ticket has been updated"
			redirect_to [@project, @ticket]
		else
			flash[:alert] = 'Ticket has not been updated'
			render 'edit'
		end	
	end
	
	def destroy
		@ticket.destroy
		flash[:notice] = 'Ticket has been deleted'
		redirect_to @project
	end
	
	private
	
	def find_project
		@project = Project.for(current_user).find(params[:project_id])
	rescue
		ActiveRecord::RecordNotFound
		redirect_to root_path, alert: "The project you were looking for does not exist"
	end
	
	def find_ticket
		@ticket = @project.tickets.find(params[:id])
	rescue
		ActiveRecord::RecordNotFound
		redirect_to root_path, alert: "The ticket you were looking for does not exist"
	end
	
	def authorize_create!
		if !current_user.admin? && cannot?("create tickets".to_sym, @project )
			redirect_to @project, alert: "You cannot create tickets on this project"
		end
	end
	
	def authorize_update!
		if !current_user.admin? && cannot?(:"edit tickets".to_sym, @project )
			redirect_to @project, alert: "You cannot edit tickets on this project"
		end
	end
	
	def authorize_delete!
		if !current_user.admin? && cannot?(:"delete tickets".to_sym, @project )
			redirect_to @project, alert: "You cannot delete tickets on this project"
		end
	end
end
