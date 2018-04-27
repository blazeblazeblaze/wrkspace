require 'rails_helper'

describe UserSearch do
  let(:user_record) { create(:user) }

  subject { described_class.new(search_params) }

  describe '#results' do
    context 'when no search_attrs passed' do
      let(:search_params) { {} }

      it 'returns no records' do
        expect(subject.results).to eq []
      end
    end

    context 'when default search_attrs passed' do
      let(:search_params) { { account_id: user_record.account_id } }

      it 'includes user_record in its results' do
        expect(subject.results).to include user_record
      end
    end
  end
end
