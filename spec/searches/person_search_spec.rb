require 'rails_helper'

describe PersonSearch do
  let(:contact) { create(:contact) }
  let(:person_record) { create(:person, contact: contact) }
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
          { name: person_record.first_name }
        end

        it 'includes person_record in its results' do
          expect(subject.results).to include person_record
        end
      end

      context 'given non_existing name' do
        let(:search_params) do
          { name: 'FooBarBaz' }
        end

        it 'does not include person_record in its results' do
          expect(subject.results).to_not include person_record
        end
      end
    end

    describe '#search_organization_id' do
      context 'given person belongs to the organization' do
        let(:search_params) do
          { organization_id: person_record.organization_id }
        end

        it 'includes person_record in its results' do
          expect(subject.results).to include person_record
        end
      end

      context 'given person does not belong to the organization' do
        let(:search_params) do
          { organization_id: 0 }
        end

        it 'does not include person_record in its results' do
          expect(subject.results).to_not include person_record
        end
      end
    end
  end
end
