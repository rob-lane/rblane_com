Rails.application.routes.draw do
  get 'admin', :to => 'admin#index'
  namespace :admin do
    resources :articles, :except => [:show]
    resources :sessions, :only => [:new, :create, :destroy]
    resources :settings, :only => [:index, :update]
  end
  get 'articles/index'
  get 'home/index'
  root 'home#index'
end
