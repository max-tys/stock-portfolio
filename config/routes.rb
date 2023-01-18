Rails.application.routes.draw do
  resources :transactions
  root "portfolios#index"

  resources :portfolios, except: :new do
    resources :holdings, except: :new
  end
end
