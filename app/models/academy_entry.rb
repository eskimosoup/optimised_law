class AcademyEntry < ActiveRecord::Base
  include NormalizeBlankValues
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  has_many :academy_entry_downloads

  validates :title, :image, :level, :pdf_download, :summary, presence: true

  mount_uploader :image,         AcademyEntryUploader
  mount_uploader :pdf_download,  Chronicler::DocumentUploader

  scope :mailchimp_series, -> { where(display: true).where.not(mailchimp_form: nil).order(:title) }
  scope :pdf_resources, -> { where(display: true, mailchimp_form: nil).order(:title) }

  LEVELS = ['Beginner', 'Intermediate', 'Advanced']
end
