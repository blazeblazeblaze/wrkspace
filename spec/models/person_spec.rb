require 'rails_helper'

RSpec.describe Person do
  subject { build(:person) }
  context 'associations' do
    it { is_expected.to belong_to(:organization) }
    it { is_expected.to have_one(:contact) }
    it { is_expected.to have_many(:cases) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe '#name' do
    it 'returns full name' do
      expect(subject.name).to eq [subject.first_name, subject.last_name].join(' ')
    end
  end
end
