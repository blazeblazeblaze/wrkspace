class Contacts::ContactsController < ApplicationController
  def index
    @search = search_params
    @contacts = ContactSearch.new(
      search_params
    ).results
  end

  def update
    circles_form = ContactCirclesForm.new(contact_params)

    if circles_form.save
      flash[:notice] = 'Circles have been successfully updated.'
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = 'There was a problem with updating circles.'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def contact_params
    params.require(:contact).permit(circle_ids: []).merge(
      contact_id: params[:id]
    )
  end

  def search_params
    (params[:contact_search] || {}).merge(
      account_id: current_account.id
    )
  end
end
