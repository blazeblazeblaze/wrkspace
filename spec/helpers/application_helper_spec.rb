require 'rails_helper'

describe ApplicationHelper do
  describe '#pretty_date' do
    context 'given object is nil' do
      it 'returns nil' do
        expect(helper.pretty_date(nil)).to eq nil
      end
    end

    context 'given object is datetime' do
      let(:datetime) { DateTime.new(2018, 1, 1) }

      it 'returns parsed date' do
        expect(helper.pretty_date(datetime)).to eq '01/01/18'
      end
    end
  end

  describe '.current_class?' do
    let(:request) { double(path: root_path) }
    before do
      allow(helper).to receive(:request) { request }
    end

    context 'request path is lookup_path' do
      it 'returns nil' do
        expect(helper.current_class?(root_path)).to eq 'active'
      end
    end

    context 'request path is lookup_path' do
      let(:datetime) { DateTime.new(2018, 1, 1) }

      it 'returns parsed date' do
        expect(helper.current_class?('foo/bar/com')).to eq ''
      end
    end
  end
end
