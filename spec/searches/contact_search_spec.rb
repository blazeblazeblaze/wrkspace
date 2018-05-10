require 'rails_helper'

describe ContactSearch do
  let(:account) { create(:account) }

  subject { described_class.new(search_params) }

  describe '#results' do
    let(:contact) { create(:contact, account: account) }
    let(:contact_2) { create(:contact) }

    context 'given account_id' do
      let(:search_params) { { account_id: account.id } }

      it 'returns contacts that belong to given account' do
        expect(subject.results).to include(contact)
      end

      it 'does not return contacts that belong to a different account' do
        expect(subject.results).not_to include(contact_2)
      end
    end

    context 'given no account_id' do
      let(:search_params) { {} }

      it 'returns empty collection' do
        expect(subject.results).to eq []
      end
    end
  end

  describe '#search_circle_id' do
    let(:contact) { create(:contact, account: account) }
    let(:circle) { create(:circle, account: account) }
    let(:contact_2) { create(:contact) }
    let(:search_params) { { account_id: account.id, circle_id: circle.id } }

    before do
      create(:circle_contact, contact: contact, circle: circle)
      create(:circle_contact, contact: contact_2)
    end

    it 'returns contacts within given circle' do
      expect(subject.results).to include(contact)
    end

    it 'does not return contacts within a different circle' do
      expect(subject.results).not_to include(contact_2)
    end
  end

  describe '#search_type' do
    let(:person) { create(:contact, contactable: create(:person), account: account) }
    let(:organization) { create(:contact, contactable: create(:organization), account: account) }
    let(:search_params) { { account_id: account.id, type: 'Organization' } }

    it 'returns contacts matching given type' do
      expect(subject.results).to include(organization)
    end

    it 'does not return contacts with a different type' do
      expect(subject.results).not_to include(person)
    end
  end
end
