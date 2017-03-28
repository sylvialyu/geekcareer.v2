module Admin::JobsHelper

  def render_job_staus(job)
    if job.is_hidden
      content_tag(:span, "", :class => "fa fa-lock")
    else
      content_tag(:span, "", class: "fa fa-globe")
    end
  end

end
