class HikerPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def update?
    record == user
  end

end