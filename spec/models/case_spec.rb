require 'rails_helper'

RSpec.describe Case do
  context 'associations' do
    it { is_expected.to belong_to(:contact) }
    it { is_expected.to belong_to(:assigned_user) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:contact) }
  end
end
