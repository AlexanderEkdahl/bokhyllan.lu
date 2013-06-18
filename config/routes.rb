Bookmarket::Application.routes.draw do
  resource :user, only: [:create, :edit, :update] do
    get  'verify'
    get  'sign_in'
    get  'sign_out'
  end

  resources :items, only: [:show] do
    get 'typeahead', on: :collection

    resources :orders, only: [:new, :create, :destroy] do
      get 'buy', on: :member
    end
  end

  root 'items#index'
end
