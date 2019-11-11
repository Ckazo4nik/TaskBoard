class ProjectsController < ApplicationController

  def index
    @projects = Project.all.order('created_at ASC')
    @project = Project.new
    @tasks = Task.all.order('priority DESC')
    # @tasks = Task.where(project_id: params[:project_id] || @projects.first.id) if params[:project_id]
  end

  def create
    @project = Project.create(project_params)
    @projects =  Project.all.order('created_at ASC')
    if @project.save
      respond_to do |format|
        format.json do
          render json:  {
              attachmentPartial:
                  render_to_string(
                      partial: 'projects/project',
                      formats: :html,
                      layout: false,
                      collections: @projects
                  )
          }
        end
      end
    else
      render(:index)
    end
  end

  def update
    @project = Project.find(params[:id])
    @project.update!(project_params)
    redirect_to root_path
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy!
    render json: { status: :ok }
  end


  private

  def project_params
    params.permit(:title)
  end
end