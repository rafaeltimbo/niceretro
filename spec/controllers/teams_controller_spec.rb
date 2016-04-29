require 'rails_helper'

RSpec.describe TeamsController do
  let(:team) { create(:team) }
  describe 'GET #index' do
    before { get :index }

    it 'assigns all teams to @teams' do
      expect(assigns(:teams)).to eq([team])
    end

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :index }
  end
end
