require 'rails_helper'

describe RetrospectivesController do
  let(:retrospective) do
    create(:retrospective)
  end

  describe 'GET #index' do
    before { get :index }

    it 'assigns all retrospectives to @retrospectives' do
      expect(assigns(:retrospectives)).to eq([retrospective])
    end

    it 'assigns next retrospective to @next_retrospective' do
      expect(assigns(:next_retrospective)).to eq([retrospective])
    end

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :index }
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new retrospective to @retrospective' do
      expect(assigns(:retrospective)).to be_a_new(Retrospective)
    end

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template(:new) }
  end

  describe 'POST #create' do
    before do
      post :create, retrospective: attributes_for(:retrospective)
    end

    it { is_expected.to redirect_to retrospectives_path }
  end

  describe 'GET #edit' do
    before { get :edit, id: retrospective.id }

    it 'assigns a retrospective to be edited to @retrospective' do
      expect(assigns(:retrospective)).to eq(retrospective)
    end

    it { is_expected.to render_template :edit }
  end

  describe 'PUT #update' do
    before do
      put :update, id: retrospective.id, retrospective: { title: 'retro2' }
    end

    it 'should have the edited data' do
      expect(retrospective.reload.title).to eq('retro2')
    end

    it { is_expected.to redirect_to retrospectives_path }
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, id: retrospective.id }

    it { is_expected.to redirect_to retrospectives_path }
  end

  describe 'GET #show' do
    let!(:old_retro) do
      create(:retrospective, title: 'Old retrospective', date: '24/11/2015')
    end

    let!(:old_demand) do
      create(:demand, retrospective_id: old_retro.id, created_at: '24/11/2015')
    end

    let!(:demand) do
      create(:demand, retrospective_id: retrospective.id)
    end

    let!(:doubt) do
      create(:doubt, retrospective_id: retrospective.id)
    end

    let!(:positive_topic) do
      create(:positive_topic, retrospective_id: retrospective.id)
    end

    let!(:negative_topic) do
      create(:negative_topic, retrospective_id: retrospective.id)
    end

    before { get :show, id: retrospective.id }

    it 'render show template' do
      expect(response).to render_template('show')
    end

    it 'get all latest demands' do
      expect(assigns(:latest_demands)).to eq([old_demand])
    end

    it 'get all retrospective demands' do
      expect(assigns(:demands)).to eq([demand])
    end

    it 'instantiates a new demand' do
      expect(assigns(:demand)).to be_a_new Demand
    end

    it 'get all retrospective doubts' do
      expect(assigns(:doubts)).to eq([doubt])
    end

    it 'instantiates a new doubt' do
      expect(assigns(:doubt)).to be_a_new Doubt
    end

    it 'get all retrospective positive topics' do
      expect(assigns(:positive_topics)).to eq([positive_topic])
    end

    it 'instantiates a new negative topic' do
      expect(assigns(:positive_topic)).to be_a_new PositiveTopic
    end

    it 'get all retrospective negative topics' do
      expect(assigns(:negative_topics)).to eq([negative_topic])
    end

    it 'instantiates a new negative topic' do
      expect(assigns(:negative_topic)).to be_a_new NegativeTopic
    end
  end
end
