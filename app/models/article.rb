class Article < ActiveRecord::Base
  #attr_accessible :content, :date, :display, :image, :infographic, :summary, :team_member_id, :title
  validates :title, :summary, :content, :date, :team_member_id, presence: true

  belongs_to :team_member

  mount_uploader :image,        ArticleImageUploader
  mount_uploader :infographic,  Chronicler::DocumentUploader
  mount_uploader :guide,        Chronicler::DocumentUploader

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def self.content_types
    ['Articles', 'Guides', 'Infographics', 'Videos']
  end

  def self.approaches
    [["None", ""], ["Attract", "attract"], ["Engage", "engage"], ["Convert", "convert"]]
  end

  def self.published
    where("date <= ? AND display = ?", Date.today, true).order("date DESC")
  end

  def self.articles
    where("date <= :date AND news_content = :true",
          date: Date.today, true: true).order("date DESC")
  end

  def self.academy
    where("date <= :date AND academy_content = :true",
          date: Date.today, true: true)
          .order("date DESC")
  end

  def self.academy_search(params)
    approach_query = filter_query = ''

    unless params[:filters].blank?

      params[:filters].each_with_index do |param, index|
        filter_query = "#{filter_query} #{param[0]} IS NOT NULL"
        filter_query = "#{filter_query} OR " unless index == params[:filters].length - 1
      end

    end

    unless params[:approaches].blank?

      params[:approaches].each_with_index do |param, index|
        approach_query = "#{approach_query} approach = '#{param[0]}'"
        approach_query = "#{approach_query} OR " unless index == params[:approaches].length - 1
      end

    end

    if filter_query.present? and approach_query.present?

      where("date <= :date AND academy_content = :true
          AND (title LIKE :search OR content LIKE :search)
          AND (#{approach_query}) AND (#{filter_query})",
          date: Date.today, true: true, search: "%#{params[:query]}%")
      .order("date DESC")

    elsif filter_query.present? and approach_query.blank?

      where("date <= :date AND academy_content = :true
          AND (title LIKE :search OR content LIKE :search) AND (#{filter_query})",
          date: Date.today, true: true, search: "%#{params[:query]}%")
         .order("date DESC")

    elsif filter_query.blank? and approach_query.present?

      where("date <= :date AND academy_content = :true
            AND (title LIKE :search OR content LIKE :search)
            AND (#{approach_query})",
          date: Date.today, true: true, search: "%#{params[:query]}%")
      .order("date DESC")

    else
      where("date <= :date AND academy_content = :true
            AND (title LIKE :search OR content LIKE :search)",
          date: Date.today, true: true, search: "%#{params[:query]}%")
      .order("date DESC")
    end
  end

  def type
    type = ''

    unless infographic.blank?
      type = 'infographic'
    end

    unless guide.blank?
      type = "#{type} guide"
    end

    unless video.blank?
      type = "#{type} video"
    end

    unless type.present?
      type = 'article'
    end

    type.strip
  end

end
