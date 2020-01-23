class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )
    render json: customer
  end

end
