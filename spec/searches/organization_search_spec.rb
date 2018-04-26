require 'rails_helper'

describe OrganizationSearch do
  let(:contact) { create(:contact) }
  let(:organization_record) { create(:organization, contact: contact) }
  let(:default_params) { { account_id: contact.account_id } }
  subject { described_class.new(default_params.merge(search_params)) }

  describe '#results' do
    context 'when no search_attrs passed' do
      let(:default_params) { {} }
      let(:search_params) { {} }

      it 'returns no records' do
        expect(subject.results).to eq []
      end
    end

    describe '#search_name' do
      context 'given existing name' do
        let(:search_params) do
          { name: organization_record.name }
        end

        it 'includes organization_record in its results' do
          expect(subject.results).to include organization_record
        end
      end

      context 'given non_existing name' do
        let(:search_params) do
          { name: 'FooBarBaz' }
        end

        it 'does not include organization_record in its results' do
          expect(subject.results).to_not include organization_record
        end
      end
    end
  end
end
