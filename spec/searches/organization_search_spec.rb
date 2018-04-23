require 'rails_helper'

describe OrganizationSearch do
  let(:organization_record) { create(:organization) }
  subject { described_class.new(search_params) }

  describe '#results' do
    context 'when no search_attrs passed' do
      let(:search_params) do
        {}
      end

      it 'returns all records' do
        expect(subject.results).to eq [organization_record]
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
