class MailchimpSubscriptionsController < ApplicationController
  before_action :set_academy_entry

  def create
    @mailchimp_subscription = MailchimpSubscription.new(mailchimp_subscription_params)
    @mailchimp_subscription.mailchimp_list_name = @academy_entry.mailchimp_form_name
    @notice = MailchimpSubscription.subscribe(@academy_entry.mailchimp_form, mailchimp_subscription_params)
    if @notice == true && @mailchimp_subscription.save
      redirect_to thank_you_academy_entry_path(@academy_entry), notice: 'Thank you for your interest in'
    elsif @notice == 'You are already subscribed'
      redirect_to thank_you_academy_entry_path(@academy_entry), notice: @notice
    else
      flash[:error] = @notice
      render 'academy_entries/show'
    end
  end

  private

    def set_academy_entry
      @academy_entry = AcademyEntry.where(display: true).friendly.find(params[:id])
    end

    def mailchimp_subscription_params
      params.require(:mailchimp_subscription).permit(:forename, :surname, :email)
    end
end
