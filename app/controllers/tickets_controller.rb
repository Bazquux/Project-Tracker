class TicketsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :find_project
	before_filter :find_ticket, :only => [:show, :edit, :update, :destroy]
		
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
end
