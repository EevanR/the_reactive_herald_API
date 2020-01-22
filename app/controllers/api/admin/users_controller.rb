class Api::Admin::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    authorize(current_user)
    user = User.find(params[:id])
    render json: user, serializer: Users::ShowSerializer
  end

end