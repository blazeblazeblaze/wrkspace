require 'rails_helper'

describe Contacts::OrganizationsController do
  before(:all) { create(:account) }

  describe 'GET /organizations' do
    let(:search_params) do
      {
        organization_search: {
          name: 'foo'
        }
      }
    end

    before do
      create(:person)
      allow(OrganizationSearch).to receive(:new).and_call_original

      get :index, params: search_params
    end

    it 'returns 200' do
      expect(response).to be_success
    end

    it 'assigns the @organizations' do
      expect(controller.instance_variable_get(:@organizations)).not_to be_nil
    end

    it 'uses OrganizationSearch to retrieve records' do
      expect(OrganizationSearch).to have_received(:new)
    end
  end

  describe 'GET /show' do
    let(:organization) { create(:organization) }

    before do
      get :show, params: { id: organization.id }
    end

    it 'returns 200' do
      expect(response).to be_success
    end

    it 'assigns the @organization' do
      expect(controller.instance_variable_get(:@organization)).not_to be_nil
    end
  end

  describe 'GET /edit' do
    let(:organization) { create(:organization) }

    before do
      get :edit, params: { id: organization.id }
    end

    it 'returns 200' do
      expect(response).to be_success
    end

    it 'assigns the @organization' do
      expect(controller.instance_variable_get(:@organization)).not_to be_nil
    end
  end

  describe 'GET /new' do
    before do
      get :new
    end

    it 'returns 200' do
      expect(response).to be_success
    end

    it 'assigns the @organization' do
      expect(controller.instance_variable_get(:@organization)).not_to be_nil
    end
  end

  describe 'POST /create' do
    before do
      post :create, params: request_params
    end

    context 'when params are invalid' do
      let(:request_params) do
        {
          organization: {
            name: nil
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
          organization: attributes_for(:organization)
        }
      end

      it 'redirects back to contacts_organizations_path' do
        expect(response).to redirect_to contacts_organizations_path
      end
    end
  end

  describe 'PUT /update' do
    let!(:organization_obj) { create(:organization) }

    before do
      put :update, params: request_params
    end

    context 'when params are invalid' do
      let(:request_params) do
        {
          id: organization_obj.id,
          organization: {
            name: nil
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
          id: organization_obj.id,
          organization: {
            name: 'foo'
          }
        }
      end

      it 'redirects back to contacts_organizations_path' do
        expect(response).to redirect_to contacts_organizations_path
      end
    end
  end
end
