Rails.application.routes.draw do
  resources :categories
  root to: 'pages#home'
  get 'pages/home'
  get "about" => "pages#about" # Using 'to:' appearantly didn't work

  devise_for :users
  resources :photos, only: [:destroy]
  resources :users, only: [:show]
  resources :events, except: [:destroy] do
    resources :registrations, only: [:create]
  end
  resources :profiles, only: [:new, :edit, :create, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
