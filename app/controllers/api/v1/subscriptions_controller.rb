class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  rescue_from Stripe::InvalidRequestError, with: :invalid_token
  
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      currency: 'sek',
      amount: 999,
      description: '6 month Subscription'
    )
    
    if (charge.paid)
      current_user.role = 'subscriber'
      current_user.save
      render json: { message: "Transaction cleared"}
    end
  end
  
  private

  def invalid_token 
    render json: { error: "Transaction rejected, token invalid"}
  end 

end