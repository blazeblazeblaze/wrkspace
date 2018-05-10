class CirclesController < ApplicationController
  before_action :load_circle, only: %i[edit update]

  def new
    @circle = Circle.new
  end

  def update
    if @circle.update(circle_params)
      flash[:notice] = 'Circle has been successfully updated.'
      redirect_to circles_path
    else
      render :edit
    end
  end

  def create
    @circle = current_account.circles.build(circle_params)

    if @circle.save
      flash[:notice] = 'Circle has been successfully created.'
      redirect_to circles_path
    else
      render :new
    end
  end

  private

  def load_circle
    @circle = current_account.circles.find(params[:id])
  end

  def circle_params
    params.require(:circle).permit(:title)
  end
end
