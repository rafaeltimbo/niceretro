require 'rails_helper'

describe DoubtsController do
  let(:team) { create(:team) }
  let(:retrospective) { create(:retrospective, team: team) }
  let!(:doubt) { create(:doubt, retrospective: retrospective, team: team) }

  describe 'POST #create' do
    it 'return success status' do
      post :create, params: { team_id: retrospective.team_id,
                              retrospective_id: retrospective.id,
                              doubt: attributes_for(:doubt),
                              format: :js }
      expect(response).to have_http_status(200)
    end

    it 'creates a doubt' do
      expect do
        post :create, params: { team_id: retrospective.team_id,
                                retrospective_id: retrospective.id,
                                doubt: attributes_for(:doubt),
                                format: :js }
      end.to change { retrospective.doubts.count }.by +1
    end
  end

  describe 'DELETE #destroy' do
    it 'return success status' do
      expect do
        delete :destroy, params: { team_id: retrospective.team_id,
                                   retrospective_id: retrospective.id,
                                   id: doubt.id,
                                   format: :js }
      end.to change { retrospective. doubts.count }.by -1
    end

    it 'delete a doubt' do
      expect do
        delete :destroy, params: { team_id: retrospective.team_id,
                                   retrospective_id: retrospective.id,
                                   id: doubt.id,
                                   format: :js }
      end.to change { retrospective. doubts.count }.by -1
    end

    context 'when doubt does not exist' do
      before { doubt.destroy }

      it 'return 404 error status' do
        delete :destroy, params: { team_id: retrospective.team_id,
                                   retrospective_id: retrospective.id,
                                   id: doubt.id,
                                   format: :js }
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        delete :destroy, params: { team_id: retrospective.team_id,
                                   retrospective_id: retrospective.id,
                                   id: doubt.id,
                                   format: :js }
        expect(response).to render_template('doubts/not_found')
      end
    end
  end

  describe 'POST #edit' do
    it 'return success status' do
      post :edit, params: { team_id: retrospective.team_id,
                            retrospective_id: retrospective.id,
                            id: doubt.id,
                            format: :js }
      expect(response).to have_http_status(200)
    end

    context 'when doubt does not exist' do
      before { doubt.destroy }

      it 'return 404 error status' do
        post :edit, params: { team_id: retrospective.team_id,
                              retrospective_id: retrospective.id,
                              id: doubt.id,
                              format: :js }
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        post :edit, params: { team_id: retrospective.team_id,
                              retrospective_id: retrospective.id,
                              id: doubt.id,
                              format: :js }
        expect(response).to render_template('doubts/not_found')
      end
    end
  end

  describe 'PUT #update' do
    it 'return success status' do
      put :update, params: { team_id: retrospective.team_id,
                             retrospective_id: retrospective.id,
                             id: doubt.id,
                             doubt: { description: 'Updated description' },
                             format: :js }
      expect(response).to have_http_status(200)
    end

    it 'change the doubt description' do
      put :update, params: { team_id: retrospective.team_id,
                             retrospective_id: retrospective.id,
                             id: doubt.id,
                             doubt: { description: 'Updated description' },
                             format: :js }
      expect(doubt.reload.description).to eq('Updated description')
    end

    context 'when doubt does not exist' do
      before { doubt.destroy }

      it 'return 404 error status' do
        put :update, params: { team_id: retrospective.team_id,
                               retrospective_id: retrospective.id,
                               id: doubt.id,
                               doubt: { description: 'Updated description' },
                               format: :js }
        expect(response).to have_http_status(404)
      end

      it 'render not_found template' do
        put :update, params: { team_id: retrospective.team_id,
                               retrospective_id: retrospective.id,
                               id: doubt.id,
                               doubt: { description: 'Updated description' },
                               format: :js }
        expect(response).to render_template('doubts/not_found')
      end
    end
  end
end
