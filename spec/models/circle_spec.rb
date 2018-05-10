require 'rails_helper'

RSpec.describe Circle do
  context 'associations' do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to have_many(:circle_contacts) }
    it { is_expected.to have_many(:contacts) }
  end
end
