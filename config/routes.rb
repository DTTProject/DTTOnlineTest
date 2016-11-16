
Rails.application.routes.draw do
  root "homepages#index"
  namespace :admin do
    root "users#index"
    resources :users
    resources :courses
  end
  post '/admin/courses' => 'admin/courses#create', as: :courses
  put '/admin/courses/:id' => 'admin/courses#update', as: :course
end
