class AcademyEntriesController < ApplicationController
  before_action :set_academy_entry, only: :show

  def index
    @academy_series    = AcademyEntry.where(display: true).where.not(mailchimp_form: nil)
    @academy_resources = AcademyEntry.where(display: true, mailchimp_form: nil)
    @marketing_assessment_signup = MarketingAssessmentSignup.new
  end

  def show
    @academy_entry_download = AcademyEntryDownload.new if @academy_entry.mailchimp_form.blank?
    redirect_to @academy_entry, status: :moved_permanently if request.path != academy_entry_path(@academy_entry)
  end

  private

    def set_academy_entry
      @academy_entry = AcademyEntry.where(display: true).friendly.find(params[:id])
    end
end
