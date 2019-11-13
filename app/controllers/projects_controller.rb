class ProjectsController < ApplicationController
  def index
    @projects = Project.all.order('created_at ASC')
    @tasks = filter_tasks
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
    params.permit(:title, :color)
  end

  def find_project
    @project = Project.find_by_title(params[:title]) if params[:title]
  end
end