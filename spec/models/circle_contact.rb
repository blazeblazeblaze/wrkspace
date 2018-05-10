require 'rails_helper'

RSpec.describe CircleContact do
  context 'associations' do
    it { is_expected.to belong_to(:circle) }
    it { is_expected.to belong_to(:contact) }
  end
end
