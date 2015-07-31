class AcademyEntryDownload
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :forename, :surname, :email

  validates :forename, :surname, :email, presence: true
  validates :email, email: true
end
