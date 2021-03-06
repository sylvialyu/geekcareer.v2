class JobRelationshipsController < ApplicationController

  def index
    @jobs = current_user.applied_jobs.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @job = Job.find(params[:id])
  end

end
