class Contacts::PeopleController < ApplicationController
  def index
    @search = search_params
    @people = PersonSearch.new(
      search_params
    ).results
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])

    if @person.update(person_params)
      flash[:success] = 'Contact has been successfully updated.'
      redirect_to contacts_people_path
    else
      render :edit
    end
  end

  def create
    @person = Person.new(person_params)

    contact = current_account.contacts.build(contactable: @person)

    if contact.save
      flash[:success] = 'Contact has been successfully created.'
      redirect_to contacts_people_path
    else
      render :new
    end
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :title, :job_title, :organization_id)
  end

  def search_params
    (params[:person_search] || {}).merge(account_id: current_account.id)
  end
end
