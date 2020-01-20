class ApplicationController < ActionController::API
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def not_authorized 
    render json: { error: "Not authorized!"}, status: 404
  end 

  protected


  def article_not_found
    render json: { error: "Article not found"}, status: 404
  end

  def meta_attributes(resource)    
    {
      current_page: resource.current_page,
      next_page: resource.next_page,
      prev_page: resource.previous_page,
      total_pages: resource.total_pages,
      total_count: resource.total_entries
    }
  end

end
