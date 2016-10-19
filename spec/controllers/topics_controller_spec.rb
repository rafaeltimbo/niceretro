require 'rails_helper'

describe TopicsController do
  let(:topic) { create(:topic) }

  describe 'POST #like' do
    it 'should increase the topic like column by 1' do
      expect do
        post :like, params: { id: topic.id, format: :js }
      end.to change { topic.reload.like }.by 1
    end
  end

  describe 'POST #dislike' do
    it 'should increase the topic dislike column by 1' do
      expect do
        post :dislike, params: { id: topic.id, format: :js }
      end.to change { topic.reload.dislike }.by 1
    end
  end
end
