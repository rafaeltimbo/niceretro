require 'rails_helper'

describe ActionsController do
  let(:retrospective) { Retrospective.create(title: 'retrotest', date: '25/11/2015', room: 4) }

  describe 'POST #create' do
    before do
      post :create,
              action: { description:'action' },
              retrospective_id: retrospective.id
    end

    it {is_expected.to redirect_to retrospective_path(retrospective.id) }
  end

  describe 'DELETE #destroy' do
    let(:action) { action.create(description: 'action1') }
    before { delete :destroy, retrospective_id: retrospective.id, id: action.id }

    it { is_expected.to redirect_to retrospective_path(retrospective.id) }
  end
end
