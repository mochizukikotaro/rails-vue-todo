class TasksController < ApplicationController

  protect_from_forgery except: ["create", "destroy"]

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
      else
        format.json {
          render json: { status: "error" }
        }
      end
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    respond_to do |format|
      format.json {
        render json: @task
      }
    end
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end


end
