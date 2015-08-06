module Admin
  class MailchimpSubscriptionsController < Manticore::ApplicationController
    before_action :set_mailchimp_subscription, only: [:edit, :update, :destroy]

    def index
      if params[:mailchimp_list_name].present?
        @mailchimp_subscriptions = MailchimpSubscription.where(mailchimp_list_name: params[:mailchimp_list_name]).order(email: :asc, created_at: :desc)
      else
        @mailchimp_subscriptions = MailchimpSubscription.order(email: :asc, created_at: :desc)
      end
    end

    private

    def set_mailchimp_subscription
      @mailchimp_subscription = MailchimpSubscription.find(params[:id])
    end

  end
end
