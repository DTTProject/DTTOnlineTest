Rails.application.routes.draw do
  root "homepages#index"
  get 'auth/:provider/callback' => 'sessions#callback'
  resources :users
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  post 'sessions/create', as: :submit_login
end
