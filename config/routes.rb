Rails.application.routes.draw do
  root "homepages#index"
  devise_for :users, controllers: {registrations: "users/registrations",
    sessions: "users/sessions"}
  namespace :admin do
    root "users#log"
    resources :courses
    resources :users do
      collection do
        get 'log'
      end
    end
    resources :questions do
      collection do
        post 'load_weeks'
      end
    end
    resources :feedbacks, only: [:index, :update]
  end
  resources :questions
  resources :users do
    member do
      get 'contributions'
    end
  end
  resources :feedbacks, only: :create
  resources :courses, only: :show
  resources :tests
  resources :comments, only: :create
  resources :weeks do
    resources :tests
    member do
      get 'exams'
      get 'challenges'
    end
  end
  resources :notes
  resources :exams
  resources :notifications
end
