Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users 
  resources :posts do
    member do 
      post :favorite
      post :like
    end
    resources :responses, :controller => 'post_replies'
  	collection do
  		get :about
  	end
  end

  get '/switch' => 'users#switch'
  resources :friendships

  namespace :admin do
    resources :groups
    resources :posts do

      collection do
        post :bulk_update
      end
    end
  end

  mount ActionCable.server => "/cable"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "posts#index"
end
