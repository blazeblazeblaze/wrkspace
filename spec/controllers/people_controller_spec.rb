require 'rails_helper'

describe Contacts::PeopleController do
  login_user
  before(:all) { create(:account) }

  describe 'GET /people' do
    let(:search_params) do
      {
        person_search: {
          name: 'foo'
        }
      }
    end

    before do
      create(:person)
      allow(PersonSearch).to receive(:new).and_call_original

      get :index, params: search_params
    end

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'assigns the @people' do
      expect(controller.instance_variable_get(:@people)).not_to be_nil
    end

    it 'uses PersonSearch to retrieve records' do
      expect(PersonSearch).to have_received(:new)
    end
  end

  describe 'GET /show' do
    let(:person) { create(:person) }

    before do
      get :show, params: { id: person.id }
    end

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'assigns the @person' do
      expect(controller.instance_variable_get(:@person)).not_to be_nil
    end
  end

  describe 'GET /edit' do
    let(:person) { create(:person) }

    before do
      get :edit, params: { id: person.id }
    end

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'assigns the @person' do
      expect(controller.instance_variable_get(:@person)).not_to be_nil
    end
  end

  describe 'GET /new' do
    before do
      get :new
    end

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'assigns the @person' do
      expect(controller.instance_variable_get(:@person)).not_to be_nil
    end
  end

  describe 'POST /create' do
    before do
      post :create, params: request_params
    end

    context 'when params are invalid' do
      let(:request_params) do
        {
          person: {
            first_name: nil
          }
        }
      end

      it 'renders :new' do
        expect(response).to render_template(:new)
      end
    end

    context 'when params are valid' do
      let(:request_params) do
        {
          person: attributes_for(:person)
        }
      end

      it 'redirects back to contacts_people_path' do
        expect(response).to redirect_to contacts_people_path
      end
    end
  end

  describe 'PUT /update' do
    let!(:person_obj) { create(:person) }

    before do
      put :update, params: request_params
    end

    context 'when params are invalid' do
      let(:request_params) do
        {
          id: person_obj.id,
          person: {
            first_name: nil
          }
        }
      end

      it 'renders :edit' do
        expect(response).to render_template(:edit)
      end
    end

    context 'when params are valid' do
      let(:request_params) do
        {
          id: person_obj.id,
          person: {
            first_name: 'foo'
          }
        }
      end

      it 'redirects back to contacts_people_path' do
        expect(response).to redirect_to contacts_people_path
      end
    end
  end
end
