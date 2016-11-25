Rails.application.routes.draw do
  root "homepages#index"
  devise_for :users, controllers: {registrations: "users/registrations",
    sessions: "users/sessions", :omniauth_callbacks => "users/omniauth_callbacks"}
  namespace :admin do
    root "users#log"
    resources :courses
    resources :users do
      collection do
        get 'log'
      end
    end
    resources :questions
  end

end
