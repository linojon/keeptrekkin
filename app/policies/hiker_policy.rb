class HikerPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def update?
    user.present? && (record.users.include? user)
  end

  def profile
    true
  end
  def profile_edit
    true
  end

end