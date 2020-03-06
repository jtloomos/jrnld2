class EntryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    record.user == user
  end

  def map?
    true
  end
end
