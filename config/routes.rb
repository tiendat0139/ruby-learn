Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'   #pages#about: pages_controller, functin about
  resources :articles
  get 'sign-up', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
