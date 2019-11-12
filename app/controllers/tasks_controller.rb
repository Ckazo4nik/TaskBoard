class TasksController < ApplicationController
  def create
    @task = Task.create(task_params)
    @tasks = Task.fresh.includes(:project).order('priority DESC')
    @projects = @tasks.map(&:project)
    if @task.save
      respond_to do |format|
        format.json do
          render json:  {
              attachmentPartial:
                  render_to_string(
                      partial: 'projects/task',
                      formats: :html,
                      layout: false,
                      collections: [@tasks, @projects]
                  )
          }
        end
      end
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update!(task_params)
    redirect_to root_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy!
    render json: { status: :ok }
  end

  def done
    @task = Task.find(params[:id])
    @task.done!
    render json: { status: :ok }
  end


  private



  def task_params
    params.permit(:name, :status, :priority, :project_id, :to_do_until)
  end
end