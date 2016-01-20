require 'rails_helper'

describe DoubtsController do
  let(:retrospective) { Retrospective.create(title: 'retrotest', date: '25/11/2015', room: 4) }
  let!(:doubt) { Doubt.create(description: 'Doubt description') }

  describe 'POST #create' do
    it 'return success status' do
      post :create, doubt: { description: 'Doubt description' }, retrospective_id: retrospective.id, format: :js
      expect(response).to have_http_status(200)
    end

    it 'creates a doubt' do
      expect do
        post :create, doubt: { description: 'Doubt description' }, retrospective_id: retrospective.id, format: :js
      end.to change { Doubt.count }.by +1
    end
  end

  describe 'DELETE #destroy' do
    it 'return success status' do
      expect do
        delete :destroy, retrospective_id: retrospective.id, id: doubt.id, format: :js
      end.to change { Doubt.count }.by -1
    end

    it 'delete a doubt' do
      expect do
        delete :destroy, retrospective_id: retrospective.id, id: doubt.id, format: :js
      end.to change { Doubt.count }.by -1
    end

    context 'when doubt does not exist' do
      before { doubt.destroy }

      it 'return 404 error status' do
        delete :destroy, retrospective_id: retrospective.id, id: doubt.id, format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        delete :destroy, retrospective_id: retrospective.id, id: doubt.id, format: :js
        expect(response).to render_template('doubts/not_found')
      end
    end
  end

  describe 'POST #edit' do
    it 'return success status' do
      post :edit, retrospective_id: retrospective.id, id: doubt.id, format: :js
      expect(response).to have_http_status(200)
    end

    context 'when doubt does not exist' do
      before { doubt.destroy }

      it 'return 404 error status' do
        post :edit, retrospective_id: retrospective.id, id: doubt.id, format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        post :edit, retrospective_id: retrospective.id, id: doubt.id, format: :js
        expect(response).to render_template('doubts/not_found')
      end
    end
  end

  describe 'PUT #update' do
    it 'return success status' do
      put :update, retrospective_id: retrospective.id, id: doubt.id, format: :js, doubt: { description: 'Updated description' }
      expect(response).to have_http_status(200)
    end

    it 'change the doubt description' do
      put :update, retrospective_id: retrospective.id, id: doubt.id, format: :js, doubt: { description: 'Updated description' }
      expect(doubt.reload.description).to eq('Updated description')
    end

    context 'when doubt does not exist' do
      before { doubt.destroy }

      it 'return 404 error status' do
        put :update, retrospective_id: retrospective.id, id: doubt.id, format: :js, doubt: { description: 'Updated description' }
        expect(response).to have_http_status(404)
      end

      it 'render not_found template' do
        put :update, retrospective_id: retrospective.id, id: doubt.id, format: :js, doubt: { description: 'Updated description' }
        expect(response).to render_template('doubts/not_found')
      end
    end
  end
end
