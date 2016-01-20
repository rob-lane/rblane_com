Rails.application.routes.draw do
  namespace :admin do
    resources :articles, :except => [:show]
    resources :sessions, :only => [:new, :create, :destroy]
  end
  get 'home/index'
  root 'home#index'
end
