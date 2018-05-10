require 'rails_helper'

describe CirclesController do
  login_user

  describe 'GET /new' do
    before do
      get :new
    end

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'assigns the @circle' do
      expect(controller.instance_variable_get(:@circle)).not_to be_nil
    end
  end

  describe 'POST /create' do
    before do
      post :create, params: request_params
    end

    context 'when params are invalid' do
      let(:request_params) do
        {
          circle: {
            title: nil
          }
        }
      end

      it 'renders :new' do
        expect(response).to render_template(:new)
      end
    end

    context 'when params are valid' do
      let(:contact) { create(:contact) }
      let(:user) { create(:user) }

      let(:request_params) do
        {
          circle: {
            title: 'foo'
          }
        }
      end

      it 'redirects back to circles_path' do
        expect(response).to redirect_to circles_path
      end
    end
  end

  describe 'PUT /update' do
    let!(:circle) { create(:circle, account: subject.current_account) }

    before do
      put :update, params: request_params
    end

    context 'when params are invalid' do
      let(:request_params) do
        {
          id: circle.id,
          circle: {
            title: nil
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
          id: circle.id,
          circle: {
            title: 'foo'
          }
        }
      end

      it 'redirects back to circles_path' do
        expect(response).to redirect_to circles_path
      end
    end
  end
end
