# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_projects, only: %i[create archive]
  before_action :find_task, only: %i[destroy done update]

  respond_to :json, only: :done
  respond_to :html, only: %i[create update archive]

  def create
    @task  = Task.create(task_params)
    @tasks = filter_tasks
    if @task.save
      respond_to do |format|
        format.json do
          render json: {
            attachmentPartial:
                               render_to_string(
                                 partial:     'projects/task',
                                 formats:     :html,
                                 layout:      false,
                                 collections: [@tasks, @projects]
                               )
          }
        end
      end
    end
  end

  def update
    @task.update!(task_params)
    respond_with @task, location: -> { root_path }
  end

  def destroy
    respond_with @task.destroy!
  end

  def done
    @task.done!
    respond_with @task
  end

  def archive
    @tasks = Task.done.order('created_at ASC')
    respond_with @tasks
  end

  private

  def task_params
    params.permit(:name, :status, :priority, :project_id, :to_do_until)
  end

  def load_projects
    @projects = Project.all
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def filter_tasks
    Task.fresh
      .filter_by_project(params[:project_id])
      .filter_by_date_range(params[:date_range])
  end
end
