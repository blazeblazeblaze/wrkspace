require 'rails_helper'

RSpec.describe Contact do
  context 'associations' do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to belong_to(:contactable) }
    it { is_expected.to have_many(:cases) }
  end

  describe '#name' do
    context 'when contactable is company' do
      let(:organization) { build(:organization) }
      subject { build(:contact, contactable: organization) }
      it 'returns organization name' do
        expect(subject.name).to eq organization.name
      end
    end

    context 'when contactable is person' do
      let(:person) { build(:person) }
      subject { build(:contact, contactable: person) }

      it 'returns full name' do
        expect(subject.name).to eq [person.first_name, person.last_name].join(' ')
      end
    end
  end
end
