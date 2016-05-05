require 'rails_helper'

RSpec.describe Retrospective, type: :model do
  let(:retrospective) { create(:retrospective) }

  it { is_expected.to belong_to(:team) }

  describe '#is_enabled?' do
    context 'when not exists a newer retrospective' do
      it 'return true' do
        expect(retrospective.is_enabled?).to be true
      end
    end

    context 'when a newer retrospective of same team already exists' do
      before do
        create(:retrospective,
                team: retrospective.team,
                title: 'Newer retro',
                date: '26/11/2015')
      end

      it 'return false' do
        expect(retrospective.is_enabled?).to be false
      end
    end

    context 'when a newer retrospective of other team already exists' do
      before do
        create(:retrospective, title: 'Newer retro', date: '26/11/2015')
      end

      it 'return false' do
        expect(retrospective.is_enabled?).to be true
      end
    end
  end
end
