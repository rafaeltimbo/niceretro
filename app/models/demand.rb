class Demand < ActiveRecord::Base
  belongs_to :team
  belongs_to :retrospective

  scope :latest_demands, ->(retrospective) {
    order(created_at: :asc)
    .where(status: false).where.not(retrospective_id: retrospective.id)
    .where('created_at < ?', retrospective.date)
  }

  def opened_days
    (Date.today - self.created_at.to_date).to_i
  end
end
