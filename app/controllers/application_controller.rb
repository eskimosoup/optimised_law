class ApplicationController < ActionController::Base

  before_filter :set_seo_variables

  def sitemap
    @seo_entries = SeoEntry.where(:in_sitemap => true).order(:nominal_url)

    respond_to do |format|
      format.html
      format.xml
    end
  end

  def set_seo_variables
    seo_entry = SeoEntry.find_by_nominal_url(request.path)
    if seo_entry
      @title = seo_entry.title
      @meta_description = seo_entry.meta_description
      @meta_tags = seo_entry.title
    end
  end

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


end
