class TasksController < ApplicationController

  protect_from_forgery :except => ["create"]

  def index
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json {
        @tasks = Task.all
        render json: @tasks
      }
    end
  end

  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path }
        format.json {
          render json: @task
        }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end


end
