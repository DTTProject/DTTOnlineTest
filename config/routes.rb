Rails.application.routes.draw do
  root "homepages#index"
  namespace :admin do
    root "users#index"
    resources :users
    resources :questions
  end
end
