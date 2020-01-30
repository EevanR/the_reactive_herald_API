class Api::V1::ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :article_not_found

  def index
    
    if params[:location] && params[:category]
      articles = Article.where(location: params[:location], category: params[:category])
    elsif params[:location]
      articles = Article.where(location: params[:location])
    elsif params[:category]
      articles = Article.where(category: params[:category])
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