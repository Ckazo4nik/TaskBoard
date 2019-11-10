class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def create
    @project = Project.create(project_params)
    if @project.save
      redirect_to root_path
    else
      render(:index)
    end
  end


  private

  def project_params
    params.permit(:title)
  end
end