Rails.application.routes.draw do
  root :to => "subs#index"
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy
  resources :posts, except: [:destroy, :index] do
    resources :comments, only: [:new]
    member do
      get 'upvote'
      get 'downvote'
    end
  end
  resources :comments, only: [:create, :show] do
    member do
      get 'upvote'
      get 'downvote'
    end
  end
end
