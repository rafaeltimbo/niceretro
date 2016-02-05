require 'rails_helper'

RSpec.describe Retrospective, type: :model do
  let(:retrospective) { create(:retrospective) }

  describe '#is_enabled?' do
    context 'when not exists a newer retrospective' do
      it 'return true' do
        expect(retrospective.is_enabled?).to be true
      end
    end

    context 'when a newer retrospective already exists' do
      before do
        create(:retrospective, title: 'Newer retro', date: '26/11/2015')
      end

      it 'return false' do
        expect(retrospective.is_enabled?).to be false
      end
    end
  end
end
