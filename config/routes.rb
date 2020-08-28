Rails.application.routes.draw do
  resources :categories
  resources :posts
  devise_for :users
  root 'posts#index'
  get 'about', to: 'pages#about'  # De ese modo podemos poner en href <%= about_path %>
  get 'pages/projects', to: 'pages#projects'
  get 'error', to: 'pages#error'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
