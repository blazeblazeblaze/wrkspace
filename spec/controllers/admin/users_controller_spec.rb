require 'rails_helper'

describe Admin::UsersController do
  context 'when user is not an admin' do
    login_user

    subject { get :index }

    it 'redirects to root_path' do
      expect(subject).to redirect_to root_path
    end
  end

  context 'when user is an admin' do
    login_admin

    describe 'GET index' do
      before { get :index }

      it 'returns 200' do
        expect(response).to be_successful
      end

      it 'assigns the @users' do
        expect(assigns(:users)).not_to be_empty
      end
    end

    describe 'GET new' do
      before { get :new }

      it 'returns 200' do
        expect(response).to be_successful
      end

      it 'assigns new instance of AccountInvitationForm' do
        expect(assigns(:invitation_form)).to be_kind_of(AccountInvitationForm)
      end
    end

    describe 'POST create' do
      let(:user_params) { { email: 'foo@bar.com' } }
      let(:errors) { double(full_messages: []) }
      let(:account_invitation_form) do
        instance_double(AccountInvitationForm, errors: errors)
      end

      before do
        allow(AccountInvitationForm).to receive(:new) { account_invitation_form }
        allow(account_invitation_form).to receive(:save) { save_status }

        post :create, params: { account_invitation_form: user_params }
      end

      context 'given email was successfully invited' do
        let(:save_status) { true }

        it 'redirects to admin_users_path' do
          expect(response).to redirect_to admin_users_path
        end
      end

      context 'given email was not invited' do
        let(:save_status) { false }

        it 'sets flash[:errors] with account_invitation_form object errors' do
          expect(flash[:alert]).to eq errors.full_messages.to_sentence
        end

        it 'renders new template' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'PUT suspend' do
      let(:suspend_status) { true }

      before do
        allow_any_instance_of(User).to receive(:suspend!) { suspend_status }
        put :suspend, params: { user_id: subject.current_user.id }
      end

      context 'when successfully suspeneded' do
        it 'sets flash[:notice]' do
          expect(flash[:notice]).to eq 'Successfully suspened this user!'
        end
      end

      context 'when unsuccessfully suspeneded' do
        let(:suspend_status) { false }

        it 'sets flash[:errors]' do
          expect(flash[:alert]).to eq 'There was a problem with suspending this user.'
        end
      end
    end
  end
end
