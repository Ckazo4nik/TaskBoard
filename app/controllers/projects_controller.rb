# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :load_project, only: %i[index]
  before_action :find_project, only: %i[update destroy]

  respond_to :html, only: %i[update create index]
  respond_to :json, only: %i[destroy]

  def index
    @tasks = filter_tasks
    respond_with @tasks
  end

  def create
    @project  = Project.create(project_params)
    @projects = Project.all.order('created_at ASC')
    if @project.save
      respond_to do |format|
        format.json do
          render json: {
            attachmentPartial:
                               render_to_string(
                                 partial:     'projects/project',
                                 formats:     :html,
                                 layout:      false,
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
    @project.update!(project_params)
    respond_with @project, location: -> { root_path }
  end

  def destroy
    respond_with @project.destroy!
  end

  private

  def project_params
    params.permit(:title, :color)
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def load_project
    @projects = Project.all.order('created_at ASC')
  end

  def filter_tasks
    Task.fresh
      .filter_by_project(params[:project_id])
      .filter_by_date_range(params[:date_range])
  end
end
