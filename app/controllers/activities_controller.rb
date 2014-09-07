class ActivitiesController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped

  def index
    return( redirect_to root_path ) unless current_user
    @activities = PublicActivity::Activity.order('created_at DESC').page(params[:page]).per(100)
  end
end
