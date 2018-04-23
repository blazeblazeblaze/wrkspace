class CasesController < ApplicationController
  def index
    @search = search_params
    @cases = CaseSearch.new(
      search_params
    ).results
  end

  def new
    @case = Case.new
  end

  def edit
    @case = Case.find(params[:id])
  end

  def update
    @case = Case.find(params[:id])

    if @case.update(case_params)
      flash[:success] = 'Case has been successfully updated.'
      redirect_to cases_path
    else
      render :edit
    end
  end

  def create
    @case = Case.new(case_params)

    if @case.save
      flash[:success] = 'Case has been successfully created.'
      redirect_to cases_path
    else
      render :new
    end
  end

  private

  def case_params
    params.require(:case).permit(:name, :description, :state, :assigned_user_id, :contact_id).tap do |param_items|
      to_be_closed = param_items[:state] == '1'
      param_items[:closed_at] = to_be_closed ? DateTime.now : nil
    end.except(:state)
  end

  def search_params
    params[:case_search] || {}
  end
end
