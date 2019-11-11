class TasksController < ApplicationController
  def create
    @task = Task.create(task_params)
    @tasks = Task.all.order('priority DESC')
    if @task.save
      respond_to do |format|
        format.json do
          render json:  {
              attachmentPartial:
                  render_to_string(
                      partial: 'projects/task',
                      formats: :html,
                      layout: false,
                      collections: @tasks
                  )
          }
        end
      end
    end
  end

  private



  def task_params
    params.permit(:name, :status, :priority, :project_id, :to_do_until)
  end
end