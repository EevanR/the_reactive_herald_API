class Api::V1::Admin::ArticlesController < ApplicationController
  before_action :authenticate_user!

  def create
    article = current_user.articles.create(article_params.except(:image))
    authorize(article)
    attach_image(article)

    if article.persisted? && attach_image(article)
      render head: :ok
    elsif article.persisted? && !attach_image(article)
      article.destroy
      render json: { error: I18n.t('errors.img_missing') }, status: 422
    else
      render json: { error: article.errors.full_messages }, status: 422
    end
  end

  def update
    article = Article.find(params[:id])
    authorize(article)
    if article.update(article_params.merge(publisher: current_user)) && article.unpublish()
      render head: :ok
    else
      render json: { error: article.errors.full_messages }, status: 422
    end
  end

  def index
    articles = Article.where(published: params[:published])
    authorize(articles)

    if articles.present?
      render json: articles, each_serializer: Articles::IndexSerializer, role: current_user.role
    else
      render json: { error: "Missing parameters." }, status: 400
    end
  end

  private

  def article_params
    params.require(:article).permit(:title_en, :title_sv, :body_en, :body_sv, :published, :publisher_id, :image, :category)
  end

  def attach_image(article)
    params_image = params['article']['image']
    if params_image && params_image.present?
      DecodeService.attach_image(params_image, article.image)
    end
  end
end