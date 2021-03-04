Rails.application.routes.draw do
  root :to => "subs#index"
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy
end
