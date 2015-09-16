class AcademyEntriesController < ApplicationController
  before_action :set_academy_entry, only: :show

  def index
    @academy_series    = AcademyEntry.mailchimp_series
    @academy_resources = AcademyEntry.pdf_resources
    @marketing_assessment_signup = MarketingAssessmentSignup.new
  end

  def show
    @academy_entry_download = AcademyEntryDownload.new if @academy_entry.mailchimp_form.blank?
    @mailchimp_subscription = MailchimpSubscription.new if @academy_entry.mailchimp_form.present?
    redirect_to academy_entry_path(@academy_entry, forename: params[:forename], surname: params[:surname], email: params[:email]), status: :moved_permanently if request.path != academy_entry_path(@academy_entry)
  end

  private

    def set_academy_entry
      @academy_entry = AcademyEntry.where(display: true).friendly.find(params[:id])
    end
end
