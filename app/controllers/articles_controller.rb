class ArticlesController < ApplicationController

  # GET /articles
  def index
    @articles = Article.articles.page(params[:page]).per(24)
  end

  # GET /articles/1
  def show
    @article = Article.friendly.find(params[:id])
    if request.path != article_path(@article)
      redirect_to @article, status: :moved_permanently
    end
    @articles = Article.articles.limit(10)
    @team_member = @article.team_member
    #@contact = Contact.new
  end

end
