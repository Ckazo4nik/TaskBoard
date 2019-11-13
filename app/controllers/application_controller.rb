class ApplicationController < ActionController::Base

  def filter_tasks
    Task.fresh
        .filter_by_project(params[:project_id])
        .filter_by_date_range(params[:date_range])
  end
end
