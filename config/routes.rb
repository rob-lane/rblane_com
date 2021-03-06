Rails.application.routes.draw do
  get 'admin', :to => 'admin#index'
  namespace :admin do
    resources :articles, :except => [:show]
    resources :sessions, :only => [:new, :create, :destroy]
    get 'settings', :to => 'settings#index'
    match 'settings', :to => 'settings#update', via: :put
    match 'settings/revert', :to => 'settings#revert', via: :post
  end
  get 'articles/index'
  get 'home/index'
  root 'home#index'
end
