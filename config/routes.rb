Bokhyllan::Application.routes.draw do
  get 'logout', to: 'users#sign_out', as: 'sign_out_user'
  resource :user, only: :update do
    get 'sign_in'
    root 'users#show', as: ''
  end

  resources :items, only: [:show, :new, :create, :edit, :update] do
    resources :orders, only: [:show, :create, :destroy]
  end

  get 'sitemap', to: 'application#sitemap', format: :xml
  get 'about', to: 'application#about'

  root 'items#index'
end
