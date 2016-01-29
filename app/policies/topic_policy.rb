class TopicPolicy < ApplicationPolicy

  def index?
    true
  end
  # class Scope
  #   attr_reader :user, :scope
  #
  #   def resolve
  #     if user.present?
  #       scope.all
  #     else
  #       scope.recent
  #     end
  #   end
  # end

end
