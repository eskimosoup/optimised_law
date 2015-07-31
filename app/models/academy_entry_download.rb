class AcademyEntryDownload  < ActiveRecord::Base
  include NormalizeBlankValues

  belongs_to :academy_entry

  #attr_accessor :forename, :surname, :email, :academy_entry_id

  validates :forename, :surname, :email, presence: true
  validates :email, email: true
end
