Rails.application.routes.draw do
  devise_for :users 
  resources :users do 
  	collection do 
  		get :aboutme
  	end
  end
  resources :posts do
    put :favorite, on: :member
  	resources :responses, :controller => 'post_replies'


  	collection do
  		get :about
  	end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "posts#index"
end
