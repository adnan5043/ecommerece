Rails.application.routes.draw do
<<<<<<< HEAD
   resources :products do
    collection do
      get 'search'
    end
  end
=======
>>>>>>> 27d43c6c6cdd6752216d2719e640a8eb0dba41e9
 resources :orders do
    resources :payments, only: [:new, :create, :index, :destroy]
    resources :order_transactions, only: [:destroy], controller: 'order_transactions'
  end
  resources :order_items, only: [:show, :create, :new, :index, :update, :destroy]
  resources :cards, only: [:show]
  resources :products do
    resources :comments, only: [:create, :update, :destroy, :edit]
  end

  get 'profile' => 'users#show'
  # get 'welcome/index'

  devise_for :users
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
