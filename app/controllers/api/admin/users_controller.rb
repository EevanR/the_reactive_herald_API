class Api::Admin::UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    render json: user, serializer: Users::ShowSerializer
  end

end