class ArticlesController < ApplicationController
  def index
    render json: Article.all
  end

  def create
    article = Article.new article_params

    if article.save
      render json: article
    end
  end

  def destroy
    article = Article.find params[:id]

    if article.destroy
      render json: article
    end
  end

  private

  def article_params
    params.permit(:title, :summary, :url)
  end
end
