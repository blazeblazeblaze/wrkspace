require 'rails_helper'

RSpec.describe Account do
  context 'associations' do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:contacts) }
    it { is_expected.to have_many(:organizations) }
    it { is_expected.to have_many(:people) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
