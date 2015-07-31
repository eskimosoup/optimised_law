class MarketingAssessmentSignup
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :forename, :surname, :email, :company, :website, :budget

  validates :forename, :surname, :email, :company, :website, :budget, presence: true
  validates :email, email: true
end
