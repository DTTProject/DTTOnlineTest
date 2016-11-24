Rails.application.routes.draw do
  root "homepages#index"
  devise_for :users, controllers: {registrations: "users/registrations",
    sessions: "users/sessions"}
  namespace :admin do
    root "users#index"
    resources :courses
    resources :users
    resources :questions
  end
end
