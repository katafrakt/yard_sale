Rails.application.routes.draw do
  resources :sales do
    resources :offers, only: [:show], path: "offer"
  end

  namespace :admin do
    #resources :sales
  end

  mount RailsEventStore::Browser => "/res" if Rails.env.development?

  root "home#index"
end
