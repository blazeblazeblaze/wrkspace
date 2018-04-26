require 'rails_helper'

describe CaseSearch do
  let(:case_record) { create(:case, closed_at: DateTime.now) }
  let(:default_params) { { account_id: case_record.contact.account_id } }
  subject { described_class.new(default_params.merge(search_params)) }

  describe '#results' do
    context 'when no search_attrs passed' do
      let(:default_params) { {} }
      let(:search_params) { {} }

      it 'returns no records' do
        expect(subject.results).to eq []
      end
    end
  end

  describe '#search_name' do
    context 'given existing name' do
      let(:search_params) do
        { name: case_record.name }
      end

      it 'includes case_record in its results' do
        expect(subject.results).to include case_record
      end
    end

    context 'given non_existing name' do
      let(:search_params) do
        { name: 'FooBarBaz' }
      end

      it 'does not include case_record in its results' do
        expect(subject.results).to_not include case_record
      end
    end
  end

  describe '#search_organization_id' do
    context 'given contact belongs to the case' do
      let(:search_params) do
        { contact_id: case_record.contact_id }
      end

      it 'includes case_record in its results' do
        expect(subject.results).to include case_record
      end
    end

    context 'given contact does not belong to the case' do
      let(:search_params) do
        { contact_id: 0 }
      end

      it 'does not include case_record in its results' do
        expect(subject.results).to_not include case_record
      end
    end
  end

  describe '#search_state' do
    context 'given state is all' do
      let(:search_params) do
        { state: 'all' }
      end

      it 'includes case_record in its results' do
        expect(subject.results).to include case_record
      end
    end

    context 'given state is close' do
      let(:search_params) do
        { state: 'close' }
      end

      it 'includes case_record in its results' do
        expect(subject.results).to include case_record
      end
    end

    context 'given state is open' do
      let(:search_params) do
        { state: 'open' }
      end

      it 'does not include case_record in its results' do
        expect(subject.results).to_not include case_record
      end
    end
  end
end
