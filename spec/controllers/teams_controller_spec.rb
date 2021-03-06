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

  describe 'GET #new' do
    before { get :new, xhr: true, format: :js }

    it 'assigns a new team to @team' do
      expect(assigns(:team)).to be_a_new(Team)
    end

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template(:new) }
  end

  describe 'POST #create' do
    it 'return success status' do
      post :create, params: { team: attributes_for(:team), format: :js }
      expect(response).to have_http_status(200)
    end

    it 'creates a team' do
      expect do
        post :create, params: { team: attributes_for(:team), format: :js }
      end.to change { Team.count }.by +1
    end
  end
end
