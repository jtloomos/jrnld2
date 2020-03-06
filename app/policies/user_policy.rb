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

<<<<<<< HEAD
  def preferences?
    true
  end

  def new_preferences?
    true
=======
  def destroy?
    @user == record
>>>>>>> master
  end
end
