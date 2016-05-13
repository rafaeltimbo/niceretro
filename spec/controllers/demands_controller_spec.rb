require 'rails_helper'

describe DemandsController do
  let(:team) { create(:team) }
  let(:retrospective) { create(:retrospective, team: team) }
  let!(:demand) { create(:demand, retrospective: retrospective, team: team) }


  describe 'POST #create' do
    it 'return success status' do
      post :create, team_id: retrospective.team_id,
                    retrospective_id: retrospective.id,
                    demand: attributes_for(:demand),
                    format: :js
      expect(response).to have_http_status(200)
    end

    it 'create a demand' do
      expect do
        post :create, team_id: retrospective.team_id,
                      retrospective_id: retrospective.id,
                      demand: attributes_for(:demand),
                      format: :js
      end.to change { team.demands.count }.by +1
    end
  end

  describe 'DELETE #destroy' do
    it 'return success status' do
      delete :destroy, team_id: retrospective.team_id,
                       retrospective_id: retrospective.id,
                       id: demand.id,
                       format: :js
      expect(response).to have_http_status(200)
    end

    it 'delete a demand' do
      expect do
        delete :destroy, team_id: retrospective.team_id,
                         retrospective_id: retrospective.id,
                         id: demand.id,
                         format: :js
      end.to change { team.demands.count }.by -1
    end

    context 'when demand does not exist' do
      before { demand.destroy }

      it 'return 404 error status' do
        delete :destroy, team_id: retrospective.team_id,
                         retrospective_id: retrospective.id,
                         id: demand.id,
                         format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        delete :destroy, team_id: retrospective.team_id,
                         retrospective_id: retrospective.id,
                         id: demand.id,
                         format: :js
        expect(response).to render_template('demands/not_found')
      end
    end
  end

  describe 'POST #edit' do
    it 'return success status' do
      post :edit, team_id: retrospective.team_id,
                  retrospective_id: retrospective.id,
                  id: demand.id,
                  format: :js,
                  demand: { description: 'Updated description' }
      expect(response).to have_http_status(200)
    end

    context 'when demand does not exist' do
      before { demand.destroy }

      it 'return 404 error status' do
        post :edit, team_id: retrospective.team_id,
                    retrospective_id: retrospective.id,
                    id: demand.id,
                    format: :js,
                    demand: { description: 'Updated description' }
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        post :edit, team_id: retrospective.team_id,
                    retrospective_id: retrospective.id,
                    id: demand.id,
                    format: :js,
                    demand: { description: 'Updated description' }
        expect(response).to render_template('demands/not_found')
      end
    end
  end

  describe 'PUT #update' do
    it 'return success status' do
      put :update, team_id: retrospective.team_id,
                   retrospective_id: retrospective.id,
                   id: demand.id,
                   format: :js,
                   demand: { description: 'Updated description' }
      expect(response).to have_http_status(200)
    end

    it 'change the demand description' do
      put :update, team_id: retrospective.team_id,
                   retrospective_id: retrospective.id,
                   id: demand.id,
                   format: :js,
                   demand: { description: 'Updated description' }
      expect(demand.reload.description).to eq('Updated description')
    end

    context 'when demand does not exist' do
      before { demand.destroy }

      it 'return 404 error status' do
        put :update, team_id: retrospective.team_id,
                  retrospective_id: retrospective.id,
                  id: demand.id,
                  format: :js,
                  demand: { description: 'Updated description' }
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        put :update, team_id: retrospective.team_id,
                     retrospective_id: retrospective.id,
                     id: demand.id,
                     format: :js,
                     demand: { description: 'Updated description' }
        expect(response).to render_template('demands/not_found')
      end
    end
  end

  describe 'POST #update_status' do
    it 'return success status' do
      post :update_status, team_id: retrospective.team_id,
                           retrospective_id: retrospective.id,
                           id: demand.id,
                           format: :js,
                           demand: { status: true }
      expect(response).to have_http_status(200)
    end

    it 'change the demand status' do
      post :update_status, team_id: retrospective.team_id,
                           retrospective_id: retrospective.id,
                           id: demand.id,
                           format: :js,
                           demand: { status: true }
      expect(demand.reload.status).to be true
    end

    context 'when resolve a demand' do
      it 'add the resolved date' do
        post :update_status, team_id: retrospective.team_id,
                             retrospective_id: retrospective.id,
                             id: demand.id,
                             format: :js,
                             demand: { status: true }
        expect(demand.reload.resolved_at.to_date).to eq(Date.today)
      end
    end

    context 'when get back on a resolved demand' do
      before do
        post :update_status, team_id: retrospective.team_id,
                             retrospective_id: retrospective.id,
                             id: demand.id,
                             format: :js,
                             demand: { status: true }
      end

      it 'remove the resolve date' do
        post :update_status, team_id: retrospective.team_id,
                             retrospective_id: retrospective.id,
                             id: demand.id,
                             format: :js,
                             demand: { status: false }
        expect(demand.reload.resolved_at).to be_nil
      end
    end

    context 'when demand does not exist' do
      before { demand.destroy }

      it 'return 404 error status' do
        post :update_status, team_id: retrospective.team_id,
                             retrospective_id: retrospective.id,
                             id: demand.id,
                             format: :js,
                             demand: { status: true }
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        post :update_status, team_id: retrospective.team_id,
                             retrospective_id: retrospective.id,
                             id: demand.id,
                             format: :js,
                             demand: { status: true }
        expect(response).to render_template('demands/not_found')
      end
    end
  end
end
