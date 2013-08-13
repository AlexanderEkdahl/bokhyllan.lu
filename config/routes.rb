Bokhyllan::Application.routes.draw do
  resource :user, only: [:create, :update] do
    get  'verify'
    post 'reset'
    get  'sign_in'
    get  'sign_out'
    root 'users#show', as: ''
  end

  resources :items, only: [:show, :new, :create] do
    get 'autocomplete', on: :collection

    resources :orders, only: [:show, :create, :destroy]
  end

  root 'items#index'
end
