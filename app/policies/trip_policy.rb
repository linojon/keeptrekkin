class TripPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve # not used?
      if user
        # todo: definately can be optimized!
        # user.friends.map {|hiker| hiker.trips }.flatten.uniq
        user.friends.map {|hiker| hiker.trips }.flatten.uniq.sort {|a,b| b.date <=> a.date }
      else
        []
      end
    end
  end

  def create?
    user.present?
  end

  def update?
    # user.present? && record.hikers.include?( user.hiker)
    user && (record.hikers.empty? || record.hikers.include?(user)) # BUT hikers shouldnt be empty
  end

  # def scope
  #   user && user.trips.order('date DESC')
  # end

end
