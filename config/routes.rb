Rails.application.routes.draw do
  resources :sales

  namespace :admin do
    resources :sales
  end

  mount RailsEventStore::Browser => "/res" if Rails.env.development?

  root "home#index"
end
