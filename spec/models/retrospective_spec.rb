require 'rails_helper'

RSpec.describe Retrospective, type: :model do
  let(:retrospective) do
    Retrospective.create(title: 'Retro', date: '25/11/2015', room: 4)
  end

  describe '#is_enabled?' do
    context 'when not exists a newer retrospective' do
      it 'return true' do
        expect(retrospective.is_enabled?).to be true
      end
    end

    context 'when a newer retrospective already exists' do
      before do
        Retrospective.create(title: 'New retro', date: '26/11/2015', room: 5)
      end

      it 'return false' do
        expect(retrospective.is_enabled?).to be false
      end
    end
  end
end
