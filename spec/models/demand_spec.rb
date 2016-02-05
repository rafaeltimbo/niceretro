require 'rails_helper'

RSpec.describe Demand, type: :model do
  let(:demand) { create(:demand) }

  describe '#opened_days' do
    context 'when the demand was created at 01/01/2016 and compared with
      31/01/2016' do
      let(:new_demand) { create(:demand, created_at: '01/01/2016') }
      let(:date) { Date.new(2016,1,31) }

      before { Timecop.freeze(date) }

      it 'return 30' do
        expect(new_demand.opened_days).to eq(30)
      end
    end
  end
end
