class Api::Admin::ArticlesController < ApplicationController
    before_action :authenticate_user!

  def create
    authorize(current_user)
    
    article = current_user.articles.create(article_params)
    
    if article.persisted?
      render head: :ok
    else
      render json: { error: article.errors.full_messages }, status: 422
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

end