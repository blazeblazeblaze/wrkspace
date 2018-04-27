require 'rails_helper'

describe AccountHelper do
  include Devise::Test::ControllerHelpers

  describe '#current_account' do
    context 'when user is signed in' do
      before { allow(helper).to receive(:current_user) { create(:user) } }

      it 'returns current account' do
        expect(helper.current_account).not_to eq nil
      end
    end

    context 'when user is not signed in' do
      it 'returns nil' do
        expect(helper.current_account).to eq nil
      end
    end
  end
end
