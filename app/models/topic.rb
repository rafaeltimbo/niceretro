class Topic < ActiveRecord::Base
  belongs_to :team
  belongs_to :retrospective

  def improve_like
    self.increment!(:like)
  end

  def improve_dislike
    self.increment!(:dislike)
  end
end
