require 'rails_helper'

RSpec.describe Organization do
  context 'associations' do
    it { is_expected.to have_one(:contact) }
    it { is_expected.to have_many(:cases) }
    it { is_expected.to have_many(:people) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
