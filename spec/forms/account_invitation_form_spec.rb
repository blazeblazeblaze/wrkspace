require 'rails_helper'

describe AccountInvitationForm do
  subject { described_class.new(account_invitation_form_params) }

  describe '#save' do
    context 'when basic validations fail' do
      let(:account_invitation_form_params) { {} }

      it 'returns false' do
        expect(subject.save).to eq false
      end
    end

    context 'when basic validations pass' do
      let(:owner) { create(:user) }
      let(:invited) { create(:user) }
      let(:account_invitation_form_params) do
        {
          user_id: owner.id,
          email: 'foo@bar.com'
        }
      end

      before do
        allow(User).to receive(:invite!) { invited }
        allow(User).to receive(:find).and_call_original
        allow(invited).to receive(:persisted?).and_call_original

        subject.save
      end

      it 'finds an organization owner from attrs' do
        expect(User).to have_received(:find).with(
          account_invitation_form_params[:user_id]
        )
      end

      it 'assigns found @owner object to account variable' do
        expect(subject.instance_variable_get(:@owner)).to eq owner
      end

      it 'invites new User using email attr' do
        expect(User).to have_received(:invite!).with(
          {
            email: 'foo@bar.com',
            account_id: owner.account_id
          },
          owner
        )
      end

      it 'assigns new user object to @invited variable' do
        expect(subject.instance_variable_get(:@invited)).to eq invited
      end

      it 'calls persisted? on @invited object' do
        expect(invited).to have_received(:persisted?)
      end

      context 'when @invited is persisted' do
        it 'returns true' do
          expect(subject.save).to eq true
        end
      end

      context 'when @invited is not persisted' do
        let(:invited) { build(:user) }

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
