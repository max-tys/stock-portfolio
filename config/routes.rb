Rails.application.routes.draw do
  root "portfolios#index"

  resources :portfolios, except: :new do
    resources :holdings, only: [:show, :create, :destroy], shallow: true do
      resources :transactions, except: [:new, :index, :show], shallow: true
    end
  end
end
