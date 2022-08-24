class FlatPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      scope.all
      # If users can see all restaurants
      # scope.where(user: user) # If users can only see their restaurants
      # scope.where("name LIKE 't%'") # If users can only see restaurants starting with `t`
      # ...
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def my_flats?
    true
  end

  def update?
    is_user_or_admin?
    # record: the restaurant passed to the `authorize` method in controller
    # user: the `current_user` signed in with Devise
  end

  def destroy?
    is_user_or_admin?
  end

  private


  def is_user_or_admin?
    record.user == user || user.admin
  end
end
