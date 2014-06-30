class TripPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def update?
    # user.present? && record.hikers.include?( user.hiker)
    user.present? && (record.hikers.empty? || record.hikers.include?( user.hiker)) # BUT hikers shouldnt be empty
  end

end