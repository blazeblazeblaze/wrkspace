module Api
  class TasksController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :load_task, only: [:update, :destroy]

    def index
      render json: user_tasks
    end

    def create
      @task = current_user.tasks.build

      @task.save ? render_success(201) : render_error
    end

    def destroy
      @task.destroy ? render_success : render_error
    end

    def update
      @task.update(task_params) ? render_success : render_error
    end

    private

    def render_success(status_code=200)
      render json: @task, status: status_code
    end

    def render_error
      render json: { errors: @task.errors.full_messages }, status: 422
    end

    def load_task
      @task = user_tasks.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :completed_at)
    end

    def user_tasks
      TaskSearch.new(user_id: current_user.id).results
    end
  end
end
