Rails.application.routes.draw do
  root "portfolios#index"

  resources :portfolios do
    resources :holdings, except: [:index, :edit, :update], shallow: true do
      resources :transactions, except: [:index, :show], shallow: true
    end
  end
end
