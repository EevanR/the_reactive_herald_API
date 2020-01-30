class Api::V1::ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :article_not_found

  def index
    articlesCat = Article.where(category: params[:category])
    articlesLoc = Article.where(location: params[:location])
    articlesLocCat = Article.where(location: params[:location], category: params[:category])

    if params[:location] && params[:category] 
      articles = articlesLocCat
    elsif params[:location]
      articles = articlesLoc
    elsif params[:category]
      articles = articlesCat
    else 
      articles = Article.all
    end

    articles = articles.paginate(page: params[:page], per_page: 4)
    render json: articles, each_serializer: Articles::IndexSerializer, meta: meta_attributes(articles)
  end

  def show
    article = Article.find(params[:id])
    render json: article, serializer: Articles::ShowSerializer
  end

end