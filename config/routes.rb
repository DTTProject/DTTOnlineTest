Rails.application.routes.draw do
  root "homepages#index"
  resources :courses
end
