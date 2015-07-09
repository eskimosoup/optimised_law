class TeamMember < ActiveRecord::Base
  #attr_accessible :director, :display, :google_plus, :image, :job_title, :name, :position, :profile, :tag_line, :twitter

  validates :name, presence: true

  has_many :articles

  mount_uploader :image, TeamMemberImageUploader

  def self.current
    where('display = ?', true)
  end

  def self.contributors
    where('display = :true and director != :true', true: true)
  end

  def self.directors
    where('display = :true and director = :true', true: true)
  end
end
