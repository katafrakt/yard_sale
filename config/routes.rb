Rails.application.routes.draw do
  resources :sales

  namespace :admin do
    resources :sales
  end

  mount RailsEventStore::Browser => "/res" if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
