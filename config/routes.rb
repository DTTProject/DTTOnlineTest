Rails.application.routes.draw do
  root "homepages#index"
  namespace :admin do
    root "users#index"
    resources :courses
    resources :users
    resources :questions
  end
end
