Bok::Application.routes.draw do
  resource :user, only: [:create, :update] do
    get  'verify'
    get  'sign_in'
    get  'sign_out'
    root 'users#show', as: ''
  end

  resources :items, only: [:show] do
    get 'typeahead', on: :collection

    resources :orders, only: [:create, :destroy] do
      post 'buy', on: :member
      post 'cancel', on: :member
    end
  end

  root 'items#index'
end
