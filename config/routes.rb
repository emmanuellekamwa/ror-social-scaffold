Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  post 'invite', to: 'friendships#create'
  put 'invite', to: 'users#update'
  delete 'reject', to: 'users#destroy'
  delete 'unfriend', to: 'friendships#destroy'

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
