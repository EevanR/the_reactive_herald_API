class Api::V1::Admin::ArticlesController < ApplicationController
  before_action :authenticate_user!

  def create
    authorize(current_user)
    article = current_user.articles.create(article_params)
    
    if article.persisted? && attach_image(article)
      render head: :ok
    elsif article.persisted? && !attach_image(article)
      article.destroy
      render json: { error: "Please attach an image." }, status: 422
    else
      article.destroy
      render json: { error: article.errors.full_messages }, status: 422
    end
  end

  def update
    authorize(current_user)

    Article.update(params[:id], published: params[:article][:published], publisher_id: current_user.id)
  end

  def index
    authorize(current_user)

    articles = Article.where(published: false)
    render json: articles, each_serializer: Articles::IndexSerializer, role: current_user.role
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def attach_image(article)
    params_image = params['article']['image']
    if params_image && params_image.present?
      DecodeService.attach_image(params_image, article.image)
    end
  end
end