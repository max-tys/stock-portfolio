Rails.application.routes.draw do
  root "portfolios#index"

  resources :portfolios do
    resources :holdings
  end
end
