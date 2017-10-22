class TasksController < ApplicationController

  # TODO: まだ必要ない
  # protect_from_forgery except: ['index']

  def index

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json {
        @tasks = Task.all

        # QUESTION: これ、なぞ,,,
        # render json: @tasks, status: :unprocessable_entity

        render json: @tasks
      }
    end

  end

end
