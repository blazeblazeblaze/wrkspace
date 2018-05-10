require 'rails_helper'

describe TaskSearch do
  let!(:user)   { build(:user) }
  let!(:task)   { create(:task, user: user) }
  let!(:task_2) { build(:task) }

  subject { described_class.new(user_id: user.id) }

  describe '#results' do
    context 'given user_id' do
      it 'returns tasks that belong to given user' do
        expect(subject.results).to include(task)
      end

      it 'does not return tasks that belong to a different user' do
        expect(subject.results).not_to include(task_2)
      end
    end

    context 'given no user_id' do
      subject { described_class.new }

      it 'returns empty collection' do
        expect(subject.results).to eq []
      end
    end
  end
end
