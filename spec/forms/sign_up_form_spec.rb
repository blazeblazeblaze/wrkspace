require 'rails_helper'

describe SignUpForm do
  subject { described_class.new(sign_up_form_params) }

  describe '#save' do
    context 'when basic validations fail' do
      let(:sign_up_form_params) { {} }

      it 'returns false' do
        expect(subject.save).to eq false
      end
    end

    context 'when basic validations pass' do
      let!(:account) { build(:account) }

      before do
        allow(Account).to receive(:new) { account }
        allow(account.users).to receive(:build) { user }
        allow(account).to receive(:save!)
        allow(account).to receive(:valid?).and_call_original
        allow(user).to receive(:valid?).and_call_original
        allow(subject).to receive(:persist!).and_call_original

        subject.save
      end

      let(:user) { build(:user, account: account) }

      let(:sign_up_form_params) do
        {
          account_name: 'Foo',
          email: 'foo@bar.com',
          password: 'password',
          password_confirmation: 'password'
        }
      end

      it 'builds new Account from attrs' do
        expect(Account).to have_received(:new).with(
          name: sign_up_form_params[:account_name]
        )
      end

      it 'assigns newly built account object to account variable' do
        expect(subject.instance_variable_get(:@account)).to eq account
      end

      it 'builds new User from attrs' do
        expect(account.users).to have_received(:build).with(
          admin: true,
          email: 'foo@bar.com',
          password: 'password',
          password_confirmation: 'password'
        )
      end

      it 'assigns new user/admin object to @user variable' do
        expect(subject.instance_variable_get(:@admin)).to eq user
      end

      it 'calls valid? on @account object' do
        expect(account).to have_received(:valid?)
      end

      it 'calls valid? on @user object' do
        expect(user).to have_received(:valid?)
      end

      context 'when @user and @account are valid' do
        it 'calls persist!' do
          expect(subject).to have_received(:persist!)
        end

        it 'calls save! on @account object' do
          expect(account).to have_received(:save!)
        end

        it 'returns true' do
          expect(subject.save).to eq true
        end
      end

      context 'when @user or @account are invalid' do
        before do
          allow(user).to receive(:valid?) { false }
          allow(account).to receive(:valid?) { false }
        end

        it 'merges! AR errors objects. Changes error objects.' do
          expect do
            subject.save
          end.to(change { subject.errors })
        end

        it 'returns false' do
          expect(subject.save).to eq false
        end
      end
    end
  end
end
