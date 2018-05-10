require 'rails_helper'

describe Contacts::ContactsController do
  login_user

  describe 'GET index' do
    before do
      allow(ContactSearch).to receive(:new).and_call_original

      get :index
    end

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'assigns the @contacts' do
      expect(controller.instance_variable_get(:@contacts)).not_to be_nil
    end

    it 'uses ContactSearch to retrieve records' do
      expect(ContactSearch).to have_received(:new)
    end
  end

  describe 'PUT /update' do
    let(:circle) { create(:circle) }
    let!(:contact) { create(:contact) }

    before do
      put :update, params: request_params
    end

    context 'when params are invalid' do
      let(:request_params) do
        {
          id: contact.id,
          contact: {
            circle_ids: nil
          }
        }
      end

      it 'redirect_to :back / root_path' do
        expect(response).to redirect_to root_path
      end

      it 'sets flash[:alert]' do
        expect(flash[:alert]).not_to be_nil
      end
    end

    context 'when params are valid' do
      let(:request_params) do
        {
          id: contact.id,
          contact: {
            circle_ids: [circle.id]
          }
        }
      end

      it 'redirect_to :back / root_path' do
        expect(response).to redirect_to root_path
      end

      it 'sets flash[:notice]' do
        expect(flash[:notice]).not_to be_nil
      end
    end
  end
end
