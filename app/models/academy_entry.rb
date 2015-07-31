class AcademyEntry < ActiveRecord::Base
  include NormalizeBlankValues
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  validates :title, :image, :level, :pdf_download, :summary, presence: true

  mount_uploader :image,         AcademyEntryUploader
  mount_uploader :pdf_download,  Chronicler::DocumentUploader

  LEVELS = ['Beginner', 'Intermediate', 'Advanced']
end
