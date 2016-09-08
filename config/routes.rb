Rails.application.routes.draw do
  devise_for :users 
  resources :users do 
  	collection do 
  		get :aboutme
  	end
  end
  resources :posts do
    member do 
      put :favorite
    end
    
  	resources :responses, :controller => 'post_replies'


  	collection do
  		get :about
  	end
  end

  namespace :admin do
    resources :posts
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "posts#index"
end
