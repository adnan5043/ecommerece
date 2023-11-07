Rails.application.routes.draw do

get 'profile' => 'users#show'
 # get 'welcome/index'


  # resources :users, only: [:show]
  devise_for :users
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
