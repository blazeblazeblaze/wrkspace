require 'rails_helper'

describe Registrations::RegistrationsController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'GET new' do
    before { get :new }

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'exposes SignUpForm form object' do
      expect(assigns(:signup_form)).to be_kind_of(SignUpForm)
    end
  end

  describe 'POST create' do
    let(:sign_up_params) do
      {
        account_name: 'Facebook',
        email: 'foo@bar.com',
        password: 'password',
        password_confirmation: 'password'
      }
    end
    let(:admin_user) { build(:user, admin: true) }
    let(:errors) { double(full_messages: []) }
    let(:sign_up_form) do
      instance_double(SignUpForm, errors: errors)
    end

    before do
      allow(SignUpForm).to receive(:new) { sign_up_form }
      allow(sign_up_form).to receive(:save) { save_status }
      allow(sign_up_form).to receive(:admin) { admin_user }
      post :create, params: { sign_up_form: sign_up_params }
    end

    context 'when account is successfully created' do
      let(:save_status) { true }

      it 'sets flash[:notice]' do
        expect(flash[:notice]).not_to be_nil
      end
    end

    context 'when account is not created' do
      let(:save_status) { false }

      it 'renders new' do
        expect(response).to render_template(:new)
      end

      it 'sets flash[:alert]' do
        expect(flash[:alert]).to eq errors.full_messages.to_sentence
      end
    end
  end
end
