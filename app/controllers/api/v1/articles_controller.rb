class Api::V1::ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :article_not_found

  def index
    if params[:location]
      articles = Article.where(:location => params[:location]).paginate(page: params[:page], per_page: 4)
      render json: articles, each_serializer: Articles::IndexSerializer, meta: meta_attributes(articles)
    else 
      articles = Article.paginate(page: params[:page], per_page: 4)
      render json: articles, each_serializer: Articles::IndexSerializer, meta: meta_attributes(articles)
    end
    if params[:category]
      articles = Article.where(category: params[:category]).paginate(page: params[:category], per_page: 4)
    else
      articles = Article.paginate(page: params[:page], per_page: 4)
    end
    render json: articles, each_serializer: Articles::IndexSerializer, meta: meta_attributes(articles)
  end

  def show
    article = Article.find(params[:id])
    render json: article, serializer: Articles::ShowSerializer
  end

end