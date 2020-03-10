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

  def preferences?
    true
  end

   def analytics?
    true
  end

  def new_preferences?
    true
  end

  def destroy?
    @user == record
  end
end
