Bok::Application.routes.draw do
  resource :user, only: [:create, :update] do
    get  'verify'
    get  'sign_in'
    get  'sign_out'
    root 'users#show', as: ''
  end

  resources :items, only: [:show] do
    collection do
      get 'typeahead'
      post 'search'
    end

    resources :orders, only: [:show, :create, :destroy] do
      post 'buy', on: :member
      post 'cancel', on: :member
    end
  end

  root 'items#index'
end
