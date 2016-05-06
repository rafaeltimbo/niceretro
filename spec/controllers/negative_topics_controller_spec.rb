require 'rails_helper'

describe NegativeTopicsController do
  let(:team) { create(:team) }
  let(:retrospective) { create(:retrospective, team: team) }
  let!(:negative_topic) { create(:negative_topic, retrospective: retrospective, team: team) }

  describe 'POST #create' do
    it 'return success status' do
      post :create, team_id: retrospective.team_id,
                    retrospective_id: retrospective.id,
                    negative_topic: attributes_for(:negative_topic),
                    format: :js
      expect(response).to have_http_status(200)
    end

    it 'create a negative topic' do
      expect do
        post :create, team_id: retrospective.team_id,
                      retrospective_id: retrospective.id,
                      negative_topic: attributes_for(:negative_topic),
                      format: :js
      end.to change { NegativeTopic.count }.by +1
    end
  end

  describe 'DELETE #destroy' do
    it 'return success status' do
      delete :destroy, retrospective_id: retrospective.id,
        id: negative_topic.id, format: :js
      expect(response).to have_http_status(200)
    end

    it 'delete a negative topic' do
      expect do
        delete :destroy, retrospective_id: retrospective.id,
          id: negative_topic.id, format: :js
      end.to change { NegativeTopic.count }.by -1
    end

    context 'when negative topic does not exist' do
      before { negative_topic.destroy }

      it 'return 404 error status' do
        delete :destroy, retrospective_id: retrospective.id,
          id: negative_topic.id, format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        delete :destroy, retrospective_id: retrospective.id,
          id: negative_topic.id, format: :js
        expect(response).to render_template('negative_topics/not_found')
      end
    end
  end

  describe 'POST #edit' do
    it 'return success status' do
      post :edit, retrospective_id: retrospective.id, id: negative_topic.id,
        format: :js
      expect(response).to have_http_status(200)
    end

    context 'when negative topic does not exist' do
      before { negative_topic.destroy }

      it 'return 404 error status' do
        post :edit, retrospective_id: retrospective.id, id: negative_topic.id,
          format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        post :edit, retrospective_id: retrospective.id, id: negative_topic.id,
          format: :js
        expect(response).to render_template('negative_topics/not_found')
      end
    end
  end

  describe 'PUT #update' do
    it 'return success status' do
      put :update, retrospective_id: retrospective.id, id: negative_topic.id,
        format: :js, negative_topic: { description: 'Updated description' }
      expect(response).to have_http_status(200)
    end

    it 'change the negative topic description' do
      put :update, retrospective_id: retrospective.id, id: negative_topic.id,
        format: :js, negative_topic: { description: 'Updated description' }
      expect(negative_topic.reload.description).to eq('Updated description')
    end

    context 'when negative topic does not exist' do
      before { negative_topic.destroy }

      it 'return 404 error status' do
        put :update, retrospective_id: retrospective.id, id: negative_topic.id,
          format: :js, negative_topic: { description: 'Updated description' }
        expect(response).to have_http_status(404)
      end

      it 'render template not found' do
        put :update, retrospective_id: retrospective.id, id: negative_topic.id,
          format: :js, negative_topic: { description: 'Updated description' }
        expect(response).to render_template('negative_topics/not_found')
      end
    end
  end
end
