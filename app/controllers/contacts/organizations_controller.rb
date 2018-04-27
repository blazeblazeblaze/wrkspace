class Contacts::OrganizationsController < ApplicationController
  def index
    @search = search_params
    @organizations = OrganizationSearch.new(
      search_params
    ).results
  end

  def show
    @organization = Organization.find(params[:id])
    @people = @organization.people
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update(organization_params)
      flash[:success] = 'Organization has been successfully updated.'
      redirect_to contacts_organizations_path
    else
      render :edit
    end
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    contact = current_account.contacts.build(contactable: @organization)

    if contact.save
      flash[:success] = 'Organization has been successfully created.'
      redirect_to contacts_organizations_path
    else
      render :new
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name).to_h
  end

  def search_params
    (params[:organization_search] || {}).merge(account_id: current_account.id)
  end
end
