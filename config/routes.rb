Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/v1/auth', skip: [:omniauth_callbacks]
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :articles, only: [:show, :index]
      namespace :admin, defaults: { format: :json } do
        resources :articles, only: [:create, :update, :index]
        resources :users, only: [:show]
        resources :subscriptions, only: [:new, :create]
      end
    end
  end
end