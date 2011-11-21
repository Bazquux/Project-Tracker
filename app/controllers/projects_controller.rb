class ProjectsController < ApplicationController
	
	before_filter :authenticate_user!, :except => [:index, :show]
	before_filter :find_project, :except => [:index, :new, :create]
	
	
	def index
		@projects = Project.all
		@title = "Listing all Projects"
	end
	
	def new
		@project = Project.new
		@title = "New Project"
	end
	
	def edit
	end
	
	def show
	end
	
	def create
		@project = Project.new(params[:project])
		if @project.save
			flash[:notice] = "Project successfully created"
			redirect_to @project
		else
			flash[:alert] = "Project was not created"
			render 'new'
		end
	end
	
	def update
		if @project.update_attributes(params[:project])
			flash[:notice] = "Project successfully updated"
			redirect_to @project
		else
			flash[:alert] = "Project was not updated"
			render 'edit'
		end
	end
	
	def destroy
		@project.destroy
		flash[:notice] = "Project has been deleted"
		redirect_to root_url
	end
	private
	
	def find_project
		@project = Project.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		flash[:alert] = "The project you were looking for could not be found"
		redirect_to projects_path
	end
end
