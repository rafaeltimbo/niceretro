require 'rails_helper'

RSpec.describe Demand, type: :model do
  it { is_expected.to belong_to(:team) }
end
