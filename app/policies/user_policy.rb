class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
	end
	
	def create?
    @user.journalist?
  end

  def update?
    @user.publisher?
  end
end
