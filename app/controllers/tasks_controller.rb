class TasksController < ApplicationController

  def index

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json {
        @tasks = Task.all
        render json: @tasks
      }
    end

  end

end
