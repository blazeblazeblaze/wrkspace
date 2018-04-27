require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }
  context 'associations' do
    it { is_expected.to belong_to(:account) }
  end

  describe '#suspend!' do
    context 'when already suspended' do
      it 'doesnt update user record' do
        expect do
          user.suspend!
        end.not_to change{user}
      end
    end

    context 'when not already suspeneded' do
      it 'sets suspended_at attribute' do
        expect do
          user.suspend!
        end.to change{user.suspended_at}
      end
    end
  end

  describe '#active_for_authentication?' do
    context 'when user not suspeneded' do
      it 'returns true' do
        expect(user.active_for_authentication?).to eq true
      end
    end

    context 'when user is suspeneded' do
      let(:user) { build(:user, suspended_at: Time.now) }

      it 'returns false' do
        expect(user.active_for_authentication?).to eq false
      end
    end
  end

  describe '#inactive_message' do
    context 'when user not suspeneded' do
      it 'returns inactive' do
        expect(user.inactive_message).to eq :inactive
      end
    end

    context 'when user is suspeneded' do
      let(:user) { build(:user, suspended_at: Time.now) }

      it 'returns suspended_account' do
        expect(user.inactive_message).to eq :suspended_account
      end
    end
  end
end
