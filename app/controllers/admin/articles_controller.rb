module Admin
  class ArticlesController < Manticore::ApplicationController

    before_action :set_article, only: [:edit, :update, :destroy]
    edit_image_for Article, :image

    def index
      @articles = Article.order('date desc')
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to admin_articles_path, notice: 'Article successfully created.'
      else
        render action: :new
      end
    end

    def edit
    end

    def update
      if @article.update_attributes(article_params)
        redirect_to admin_articles_path, notice: 'Article successfully updated.'
      else
        render action: :edit
      end
    end

    def destroy
      @article.destroy
      redirect_to admin_articles_path, notice: 'Article destroyed.'
    end

    private

    def article_params
      params.require(:article).permit!
    end

    def set_article
      @article = Article.friendly.find(params[:id])
    end

  end
end
