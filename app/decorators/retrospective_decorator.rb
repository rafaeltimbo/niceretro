require 'delegate'

class RetrospectiveDecorator < SimpleDelegator
  def schedule
    super.strftime('%H:%M') if super.present?
  end
end
