require 'rails_helper'

describe RetrospectiveDecorator do
  let(:retrospective) { create(:retrospective, schedule: Time.parse('15:00')) }
  let(:decorator) { described_class.new(retrospective) }

  describe '#schedule' do
    it 'returns formatted schedule with just hours and minutes' do
      expect(decorator.schedule).to eq('15:00')
    end
  end
end
