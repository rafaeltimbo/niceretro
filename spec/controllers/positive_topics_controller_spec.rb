require 'rails_helper'

describe PositiveTopicsController do
  let(:retrospective) { create(:retrospective) }
  let!(:positive_topic) { create(:positive_topic) }

  describe 'POST #create' do
    it 'return success status' do
      post :create, positive_topic: attributes_for(:positive_topic),
        retrospective_id: retrospective.id, format: :js
      expect(response).to have_http_status(200)
    end

    it 'creates a positive topic' do
      expect do
        post :create, positive_topic: attributes_for(:positive_topic),
          retrospective_id: retrospective.id, format: :js
      end.to change { PositiveTopic.count }.by +1
    end
  end

  describe 'DELETE #destroy' do
    it 'returns success status' do
      delete :destroy, retrospective_id: retrospective.id,
        id: positive_topic.id, format: :js
      expect(response).to have_http_status(200)
    end

    it 'removes a positive topic' do
      expect do
        delete :destroy, retrospective_id: retrospective.id,
          id: positive_topic.id, format: :js
      end.to change { PositiveTopic.count }.by -1
    end

    context 'when positive topic does not exist' do
      before do
        positive_topic.destroy
      end

      it 'return 404 error status' do
        delete :destroy, retrospective_id: retrospective.id,
          id: positive_topic.id, format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        delete :destroy, retrospective_id: retrospective.id,
          id: positive_topic.id, format: :js
        expect(response).to render_template('positive_topics/not_found')
      end
    end
  end

  describe 'POST #edit' do
    it 'return success status' do
      post :edit, retrospective_id: retrospective.id, id: positive_topic.id,
        format: :js
      expect(response).to have_http_status(200)
    end

    context 'when positive topic does not exist' do
      before do
        positive_topic.destroy
      end

      it 'return 404 error status' do
        post :edit, retrospective_id: retrospective.id, id: positive_topic.id,
          format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        post :edit, retrospective_id: retrospective.id, id: positive_topic.id,
          format: :js
        expect(response).to render_template('positive_topics/not_found')
      end
    end
  end

  describe 'PUT #update' do
    it 'return success status' do
      put :update, retrospective_id: retrospective.id, id: positive_topic.id,
        format: :js, positive_topic: { description: 'Updated description' }
      expect(response).to be_successful
    end

    it 'change the positive topic description' do
      put :update, retrospective_id: retrospective.id, id: positive_topic.id,
        format: :js, positive_topic: { description: 'Updated description' }
      expect(positive_topic.reload.description).to eq('Updated description')
    end

    context 'when positive topic does not exist' do
      before do
        positive_topic.destroy
      end

      it 'return 404 error status' do
        put :update, retrospective_id: retrospective.id, id: positive_topic.id,
          format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        put :update, retrospective_id: retrospective.id, id: positive_topic.id,
          format: :js
        expect(response).to render_template('positive_topics/not_found')
      end
    end
  end
end
