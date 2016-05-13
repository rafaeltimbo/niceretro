require 'rails_helper'

describe PositiveTopicsController do
  let(:team) { create(:team) }
  let(:retrospective) { create(:retrospective, team: team) }
  let!(:positive_topic) { create(:positive_topic, retrospective: retrospective, team: team) }

  describe 'POST #create' do
    it 'return success status' do
      post :create, team_id: retrospective.team_id,
                    retrospective_id: retrospective.id,  
                    positive_topic: attributes_for(:positive_topic),
                    format: :js
      expect(response).to have_http_status(200)
    end

    it 'creates a positive topic' do
      expect do
        post :create, team_id: retrospective.team_id,
                      retrospective_id: retrospective.id,  
                      positive_topic: attributes_for(:positive_topic),
                      format: :js
      end.to change { retrospective.positive_topics.count }.by +1
    end
  end

  describe 'DELETE #destroy' do
    it 'returns success status' do
      delete :destroy, team_id: retrospective.team_id,
                       retrospective_id: retrospective.id,
                       id: positive_topic.id,
                       format: :js
      expect(response).to have_http_status(200)
    end

    it 'removes a positive topic' do
      expect do
        delete :destroy, team_id: retrospective.team_id,
                         retrospective_id: retrospective.id,
                         id: positive_topic.id,
                         format: :js
      end.to change { retrospective.positive_topics.count }.by -1
    end

    context 'when positive topic does not exist' do
      before do
        positive_topic.destroy
      end

      it 'return 404 error status' do
        delete :destroy, team_id: retrospective.team_id,
                         retrospective_id: retrospective.id,
                         id: positive_topic.id,
                         format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        delete :destroy, team_id: retrospective.team_id,
                         retrospective_id: retrospective.id,
                         id: positive_topic.id,
                         format: :js
        expect(response).to render_template('positive_topics/not_found')
      end
    end
  end

  describe 'POST #edit' do
    it 'return success status' do
      post :edit, team_id: retrospective.team_id,
                  retrospective_id: retrospective.id,
                  id: positive_topic.id,
                  format: :js
      expect(response).to have_http_status(200)
    end

    context 'when positive topic does not exist' do
      before do
        positive_topic.destroy
      end

      it 'return 404 error status' do
        post :edit, team_id: retrospective.team_id,
                    retrospective_id: retrospective.id,
                    id: positive_topic.id,
                    format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        post :edit, team_id: retrospective.team_id,
                    retrospective_id: retrospective.id,
                    id: positive_topic.id,
                    format: :js
        expect(response).to render_template('positive_topics/not_found')
      end
    end
  end

  describe 'PUT #update' do
    it 'return success status' do
      put :update, team_id: retrospective.team_id,
                   retrospective_id: retrospective.id,
                   id: positive_topic.id,
                   positive_topic: { description: 'Updated description' },
                   format: :js
      expect(response).to be_successful
    end

    it 'change the positive topic description' do
      put :update, team_id: retrospective.team_id,
                   retrospective_id: retrospective.id,
                   id: positive_topic.id,
                   positive_topic: { description: 'Updated description' },
                   format: :js
      expect(positive_topic.reload.description).to eq('Updated description')
    end

    context 'when positive topic does not exist' do
      before do
        positive_topic.destroy
      end

      it 'return 404 error status' do
        put :update, team_id: retrospective.team_id,
                     retrospective_id: retrospective.id,
                     id: positive_topic.id,
                     positive_topic: { description: 'Updated description' },
                     format: :js
        expect(response).to have_http_status(404)
      end

      it 'render not found template' do
        put :update, team_id: retrospective.team_id,
                     retrospective_id: retrospective.id,
                     id: positive_topic.id,
                     positive_topic: { description: 'Updated description' },
                     format: :js
        expect(response).to render_template('positive_topics/not_found')
      end
    end
  end
end
