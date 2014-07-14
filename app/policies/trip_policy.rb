class TripPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user ? user.trips.order('date DESC') : []
    end
  end

  def create?
    user.present?
  end

  def update?
    # user.present? && record.hikers.include?( user.hiker)
    user && (record.hikers.empty? || record.hikers.include?(user)) # BUT hikers shouldnt be empty
  end

  def scope
    user && user.trips
  end

end
