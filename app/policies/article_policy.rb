class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    @user.journalist?
  end
  
  def index?
    @user.publisher?
  end

  def update?
    @user.publisher?
  end

  def destroy?
    @user.publisher?
  end
end
