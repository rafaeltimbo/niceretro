require 'rails_helper'

describe DemandsController do
  let(:retrospective) { Retrospective.create(title: 'retrotest', date: '25/11/2015', room: 4) }
  let!(:demand) { Demand.create(description: 'Demand description', user: '') }

  describe 'POST #create' do
    it 'return success status' do
      post :create, demand: { description: 'Demand description', user: '' }, retrospective_id: retrospective.id, format: :js
      expect(response).to have_http_status(200)
    end

    it 'create a demand' do
      expect do
        post :create, demand: { description: 'Demand description', user: '' }, retrospective_id: retrospective.id, format: :js
      end.to change { Demand.count }.by +1
    end
  end

  describe 'DELETE #destroy' do
    it 'return success status' do
      delete :destroy, retrospective_id: retrospective.id, id: demand.id, format: :js
      expect(response).to have_http_status(200)
    end

    it 'delete a demand' do
      expect do
        delete :destroy, retrospective_id: retrospective.id, id: demand.id, format: :js
      end.to change { Demand.count }.by -1
    end

    context 'when demand does not exist' do
      before { demand.destroy }

      it 'return 404 error status' do
        delete :destroy, retrospective_id: retrospective.id, id: demand.id, format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        delete :destroy, retrospective_id: retrospective.id, id: demand.id, format: :js
        expect(response).to render_template('demands/not_found')
      end
    end
  end

  describe 'POST #edit' do
    it 'return success status' do
      post :edit, retrospective_id: retrospective.id, id: demand.id, format: :js, demand: { description: 'Updated description' }
      expect(response).to have_http_status(200)
    end

    context 'when demand does not exist' do
      before { demand.destroy }

      it 'return 404 error status' do
        post :edit, retrospective_id: retrospective.id, id: demand.id, format: :js, demand: { description: 'Updated description' }
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        post :edit, retrospective_id: retrospective.id, id: demand.id, format: :js, demand: { description: 'Updated description' }
        expect(response).to render_template('demands/not_found')
      end
    end
  end

  describe 'PUT #update' do
    it 'return success status' do
      put :update, retrospective_id: retrospective.id, id: demand.id, format: :js, demand: { description: 'Updated description' }
      expect(response).to have_http_status(200)
    end

    it 'change the demand description' do
      put :update, retrospective_id: retrospective.id, id: demand.id, format: :js, demand: { description: 'Updated description' }
      expect(demand.reload.description).to eq('Updated description')
    end

    context 'when demand does not exist' do
      before { demand.destroy }

      it 'return 404 error status' do
        put :update, retrospective_id: retrospective.id, id: demand.id, format: :js, demand: { description: 'Updated description' }
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        put :update, retrospective_id: retrospective.id, id: demand.id, format: :js, demand: { description: 'Updated description' }
        expect(response).to render_template('demands/not_found')
      end
    end
  end

  describe 'POST #update_status' do
    it 'return success status' do
      post :update_status, id: demand.id, format: :js, demand: { status: true }
      expect(response).to have_http_status(200)
    end

    it 'change the demand status' do
      post :update_status, id: demand.id, format: :js, demand: { status: true }
      expect(demand.reload.status).to be true
    end

    context 'when demand does not exist' do
      before { demand.destroy }

      it 'return 404 error status' do
        post :update_status, id: demand.id, format: :js, demand: { status: true }
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        post :update_status, id: demand.id, format: :js, demand: { status: true }
        expect(response).to render_template('demands/not_found')
      end
    end
  end
end
