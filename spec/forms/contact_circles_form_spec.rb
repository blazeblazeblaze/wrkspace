require 'rails_helper'

describe ContactCirclesForm do
  subject { described_class.new(form_params) }

  describe '#save' do
    context 'when basic validations fail' do
      let(:form_params) { {} }

      it 'returns false' do
        expect(subject.save).to eq false
      end
    end

    context 'when basic validations pass' do
      let(:account) { create(:account) }
      let(:circle) { create(:circle, account: account) }
      let(:contact) { create(:contact, account: account) }

      let(:form_params) { { contact_id: contact.id, circle_ids: [circle.id] } }

      it 'builds associations between circles and contacts' do
        expect do
          subject.save
        end.to change { contact.circles.count }.from(0).to(1)
      end

      it 'returns true' do
        expect(subject.save).to eq true
      end
    end
  end
end
