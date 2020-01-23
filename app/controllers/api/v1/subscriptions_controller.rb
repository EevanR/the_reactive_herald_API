class SubscriptionsController < ApplicationController

  def new
    
  end

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: stripe_token(params),
      description: 'Crafty News Subscriber'
    )
  end

end
