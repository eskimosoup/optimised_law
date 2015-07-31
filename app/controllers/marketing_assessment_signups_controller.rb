class MarketingAssessmentSignupsController < ApplicationController
  def new
    @marketing_assessment_signup = MarketingAssessmentSignup.new
  end

  def create
    @marketing_assessment_signup = MarketingAssessmentSignup.new(marketing_assessment_signup_params)
    if @marketing_assessment_signup.valid?
      AcademyEntriesMailer.new_assessment(@marketing_assessment_signup).deliver_now
      redirect_to new_marketing_assessment_signup_path, notice: 'Thank you for your interest, please check your inbox'
    else
      render :new
    end
  end

  private

    def marketing_assessment_signup_params
      params.require(:marketing_assessment_signup).permit(:forename, :surname, :email,
                                                          :company, :website, :budget)
    end
end
