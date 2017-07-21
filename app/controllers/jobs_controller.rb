class JobsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :favorite]
  before_action :validate_search_key, only: [:search]

  def index
    @jobs = case params[:order]
    when 'by_lower_bound'
      Job.published.lower_wage.paginate(:page => params[:page], :per_page => 5)
    when 'by_upper_bound'
      Job.published.upper_wage.paginate(:page => params[:page], :per_page => 5)
    else
      Job.published.recent.paginate(:page => params[:page], :per_page => 5)
    end
  end

  def show
    @job = Job.find_by_friendly_id!(params[:id])
    if @job.is_hidden
      flash[:warning] = "This Job is already archieved."
      redirect_to root_path
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def edit
    @job = Job.find_by_friendly_id!(params[:id])
  end

  def update
    @job = Job.find_by_friendly_id!(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find_by_friendly_id!(params[:id])
    @job.destroy
    redirect_to jobs_path, alert: "Job Deleted"
  end

  def search
    if @query_string.present?
      search_result = Job.published.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end

  def favorite
    @job = Job.find(params[:id])
    type = params[:type]
    if type == "favorite"
      current_user.favorite_jobs << @job
      redirect_to :back

    elsif type == "unfavorite"
      current_user.favorite_jobs.delete(@job)
      redirect_to :back

    else
      redirect_to :back
    end
  end



  protected

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end


  def search_criteria(query_string)
    { :title_cont => query_string }
  end


  private

  def job_params
    params.require(:job).permit(:title, :description, :wage_lower_bound, :wage_upper_bound, :contact_email, :is_hidden, :company_name, :location, :published_time)
  end


end
