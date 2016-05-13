require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:positive_topic) { create(:positive_topic) }

  it { is_expected.to belong_to(:team) }

  describe '#improve_like' do
    context 'when clicking on the topic like button' do
      it 'should increase the topic like column by +1' do
        expect do
          positive_topic.improve_like
        end.to change { positive_topic.like }.by 1
      end
    end
  end

  describe '#improve_dislike' do
    context 'when clicking on the topic dislike button' do
      it 'should increase the topic dislike column by +1' do
        expect do
          positive_topic.improve_dislike
        end.to change { positive_topic.dislike }.by 1
      end
    end
  end
end
