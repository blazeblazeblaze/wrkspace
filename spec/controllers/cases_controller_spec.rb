require 'rails_helper'

describe CasesController do
  describe 'GET /cases' do
    let(:search_params) do
      {
        case_search: {
          name: 'foo'
        }
      }
    end

    before do
      create(:case)
      allow(CaseSearch).to receive(:new).and_call_original

      get :index, params: search_params
    end

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'assigns the @cases' do
      expect(controller.instance_variable_get(:@cases)).not_to be_nil
    end

    it 'uses CaseSearch to retrieve records' do
      expect(CaseSearch).to have_received(:new)
    end
  end

  describe 'GET /edit' do
    let(:case_item) { create(:case) }

    before do
      get :edit, params: { id: case_item.id }
    end

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'assigns the @case' do
      expect(controller.instance_variable_get(:@case)).not_to be_nil
    end
  end

  describe 'GET /new' do
    before do
      get :new
    end

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'assigns the @case' do
      expect(controller.instance_variable_get(:@case)).not_to be_nil
    end
  end

  describe 'POST /create' do
    before do
      post :create, params: request_params
    end

    context 'when params are invalid' do
      let(:request_params) do
        {
          case: {
            name: nil
          }
        }
      end

      it 'renders :new' do
        expect(response).to render_template(:new)
      end
    end

    context 'when params are valid' do
      let(:contact) { create(:contact) }
      let(:user) { create(:person) }
      let(:request_params) do
        {
          case: {
            name: 'foo',
            contact_id: contact.id,
            assigned_user_id: user.id
          }
        }
      end

      it 'redirects back to cases_path' do
        expect(response).to redirect_to cases_path
      end
    end
  end

  describe 'PUT /update' do
    let!(:case_obj) { create(:case) }

    before do
      put :update, params: request_params
    end

    context 'when params are invalid' do
      let(:request_params) do
        {
          id: case_obj.id,
          case: {
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
          id: case_obj.id,
          case: {
            name: 'foo'
          }
        }
      end

      it 'redirects back to cases_path' do
        expect(response).to redirect_to cases_path
      end
    end
  end
end
