class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def dashboard?
    true
  end

  def edit?
    @user == record
  end

  def update?
    @user == record
  end

  def destroy?
    @user == record
  end
end
