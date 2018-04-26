require 'rails_helper'

describe OrganizationSearch do
  let(:organization_record) { create(:organization) }
  let(:contact) { create(:contact, contactable: organization_record) }
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

    describe '#search_with_cases' do
      context 'when with_cases is set to 1' do
        let(:search_params) { { with_cases: '1' } }

        context 'when organization_record has open case assigned' do
          before { create(:case, contact: contact) }

          it 'includes organization_record in its results' do
            expect(subject.results).to include organization_record
          end
        end

        context 'when organization_record has no open cases assigned' do
          before { create(:case, contact: contact, closed_at: Time.now) }

          it 'does not include organization_record in its results' do
            expect(subject.results).to_not include organization_record
          end
        end
      end

      context 'when with_cases is not set to 1' do
        let(:search_params) { { with_cases: '5' } }

        it 'includes organization_record in its results' do
          expect(subject.results).to include organization_record
        end
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
