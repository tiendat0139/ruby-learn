Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'   #pages#about: pages_controller, functin about
end
